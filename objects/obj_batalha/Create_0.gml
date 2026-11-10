// ==========================================================
// CONFIGURAÇÃO DA FASE (tabela completa em scr_fases)
// ==========================================================

if (!variable_global_exists("fase_atual"))
{
    global.fase_atual = 1;
}

if (!variable_global_exists("fases"))
{
    global.fases = fases_criar();
}

fase = fase_dados(global.fase_atual);

ondas = fase.ondas;
recompensa_id = fase.recompensa;

onda_atual = 0;

inimigos = [];

// Lugares dos ajudantes quando há um chefe na onda
slots_ajudantes = [
    { x: 548, y: 330 },
    { x: 548, y: 172 }
];


// ==========================================================
// EQUIPE: CRIAR OS PERSONAGENS ESCOLHIDOS
// (índices iguais aos de global.personagens)
// ==========================================================

heroi_objetos = [obj_lobo, obj_iara, obj_matinta, obj_boitata, obj_saci, obj_curupira];

herois = [];

if (!variable_global_exists("equipe"))
{
    global.equipe = [0, -1, -1, -1];
}

var _ids = [];

for (var i = 0; i < array_length(global.equipe); i++)
{
    var _id = global.equipe[i];

    if (_id >= 0 && _id < array_length(heroi_objetos))
    {
        array_push(_ids, _id);
    }
}

// Segurança: se por algum motivo não há ninguém na equipe
if (array_length(_ids) == 0)
{
    array_push(_ids, 0);
}

var _n_herois = min(4, array_length(_ids));
var _pos_h = bt_posicoes_herois(_n_herois);

for (var i = 0; i < _n_herois; i++)
{
    var _inst = instance_create_layer(_pos_h[i].x, _pos_h[i].y, "Instances", heroi_objetos[_ids[i]]);

    bt_preparar(_inst, "heroi", _n_herois >= 4);

    array_push(herois, _inst);
}


// ==========================================================
// FUNÇÕES DA BATALHA
// ==========================================================

// Posiciona os inimigos recém-criados de uma onda
posicionar_inimigos = function(_lista)
{
    var _chefes = [];
    var _normais = [];

    for (var i = 0; i < array_length(_lista); i++)
    {
        var _c = _lista[i];

        if (_c.pos_fixa)
        {
            continue;
        }

        if (_c.eh_chefe)
        {
            array_push(_chefes, _c);
        }
        else
        {
            array_push(_normais, _c);
        }
    }

    if (array_length(_chefes) > 0)
    {
        for (var i = 0; i < array_length(_chefes); i++)
        {
            _chefes[i].x = _chefes[i].chefe_x;
            _chefes[i].y = _chefes[i].chefe_y;
        }

        for (var i = 0; i < array_length(_normais); i++)
        {
            var _p = slots_ajudantes[min(i, array_length(slots_ajudantes) - 1)];

            _normais[i].x = _p.x;
            _normais[i].y = _p.y;
        }
    }
    else if (array_length(_normais) > 0)
    {
        var _pos = bt_posicoes_inimigos(array_length(_normais));

        for (var i = 0; i < array_length(_normais); i++)
        {
            _normais[i].x = _pos[i].x;
            _normais[i].y = _pos[i].y;
        }
    }

    var _compacto = (array_length(_lista) >= 3);

    for (var i = 0; i < array_length(_lista); i++)
    {
        bt_preparar(_lista[i], "inimigo", _compacto);
    }
};


// Cria os inimigos da onda _indice
criar_onda = function(_indice)
{
    var _entradas = ondas[_indice];
    var _lista = [];

    for (var i = 0; i < array_length(_entradas); i++)
    {
        var _e = _entradas[i];

        var _inst = instance_create_layer(0, 0, "Instances", _e.obj);

        if (variable_struct_exists(_e, "x") && variable_struct_exists(_e, "y"))
        {
            _inst.x = _e.x;
            _inst.y = _e.y;
            _inst.pos_fixa = true;
        }

        array_push(_lista, _inst);
    }

    posicionar_inimigos(_lista);

    return _lista;
};


// Chefe chama um reforço para um lugar livre
invocar = function(_chefe)
{
    if (_chefe.invoca_obj == noone)
    {
        return noone;
    }

    for (var s = 0; s < array_length(slots_ajudantes); s++)
    {
        var _p = slots_ajudantes[s];
        var _ocupado = false;

        for (var i = 0; i < array_length(inimigos); i++)
        {
            var _e = inimigos[i];

            if (instance_exists(_e) && _e.hp > 0 && _e.x_original == _p.x && _e.y_original == _p.y)
            {
                _ocupado = true;
            }
        }

        if (!_ocupado)
        {
            var _novo = instance_create_layer(_p.x, _p.y, "Instances", _chefe.invoca_obj);

            bt_preparar(_novo, "inimigo", true);

            array_push(inimigos, _novo);

            return _novo;
        }
    }

    return noone;
};


// Remove inimigos derrotados da lista (eles somem aos poucos)
limpar_inimigos = function()
{
    var _restantes = [];

    for (var i = 0; i < array_length(inimigos); i++)
    {
        var _e = inimigos[i];

        if (instance_exists(_e) && _e.hp > 0)
        {
            array_push(_restantes, _e);
        }
        else if (instance_exists(_e))
        {
            _e.morrendo = true;
        }
    }

    inimigos = _restantes;
};


// Passa a vez para o próximo herói vivo a partir de _inicio.
// Se não houver mais heróis, começa o turno dos inimigos.
proximo_heroi = function(_inicio)
{
    var _prox = bt_proximo_vivo(herois, _inicio);

    if (_prox == -1)
    {
        mensagem = "Os inimigos vão atacar!";

        inimigo_indice = 0;
        inimigo_limite = array_length(inimigos);

        estado = "turno_inimigos";

        timer = 0;

        return;
    }

    heroi_indice = _prox;
    heroi_atual = herois[heroi_indice];

    if (heroi_atual.atordoado > 0)
    {
        heroi_atual.atordoado--;

        mensagem = heroi_atual.nome + " está preso na armadilha e perdeu a vez!";

        estado = "heroi_atordoado";

        timer = 0;

        return;
    }

    mensagem = heroi_atual.nome + ", escolha um ataque!";

    estado = "jogador_ataque";

    timer = 0;
};


// Executa a ação escolhida pelo herói nos alvos da lista
executar_acao = function(_alvos)
{
    bt_animar_ataque(heroi_atual);

    var _qtd_efeito = 0;
    var _ultimo = noone;
    var _n_alvos = 0;

    for (var i = 0; i < array_length(_alvos); i++)
    {
        var _t = _alvos[i];

        if (!instance_exists(_t) || _t.hp <= 0)
        {
            continue;
        }

        _n_alvos++;
        _ultimo = _t;

        bt_aplicar_efeito(_t, acao.tipo, acao.valor);

        if (acao.efeito != "" && _t.hp > 0)
        {
            var _chance = acao.chance;

            // chefes resistem a ser atordoados
            if (acao.efeito == "atordoar" && _t.eh_chefe)
            {
                _chance = _chance * 0.5;
            }

            if (random(100) < _chance)
            {
                if (bt_aplicar_status(_t, acao.efeito, acao.turnos, acao.efeito_valor))
                {
                    _qtd_efeito++;
                }
            }
        }
    }

    mensagem = heroi_atual.nome + " usou " + acao.nome;

    if (array_length(_alvos) == 1 && _ultimo != noone)
    {
        mensagem += " em " + _ultimo.nome;
    }

    mensagem += "!";

    if (_qtd_efeito > 0)
    {
        mensagem += " " + bt_texto_efeito(acao.efeito, _qtd_efeito);
    }

    estado = "verificar_acao";

    timer = 0;
};


// Ação de um inimigo no turno dele
acao_inimigo = function(_ini)
{
    // atordoado: perde a vez
    if (_ini.atordoado > 0)
    {
        _ini.atordoado--;

        mensagem = _ini.nome + " está atordoado e perdeu a vez!";

        return;
    }

    _ini.contador_turnos++;

    // fúria: chefe com pouca vida fica mais forte
    if (_ini.furia_limite > 0 && !_ini.furia && _ini.hp <= _ini.hp_max * _ini.furia_limite)
    {
        _ini.furia = true;
        _ini.ataque_dano = round(_ini.ataque_dano * 1.3);
        _ini.ataque_especial_dano = round(_ini.ataque_especial_dano * 1.3);

        bt_animar_ataque(_ini);
        bt_texto_flutuante(_ini, "FÚRIA!", make_color_rgb(255, 80, 60));

        mensagem = _ini.nome + " entrou em FÚRIA!";

        return;
    }

    // reforços
    if (
        _ini.invoca_turnos > 0 &&
        _ini.contador_turnos mod _ini.invoca_turnos == 0 &&
        _ini.invocacoes < _ini.invoca_total &&
        bt_contar_vivos(inimigos) < _ini.invoca_max
    )
    {
        var _novo = invocar(_ini);

        if (_novo != noone)
        {
            _ini.invocacoes++;

            bt_animar_ataque(_ini);

            mensagem = _ini.nome + " chamou reforços: " + _novo.nome + "!";

            return;
        }
    }

    var _dano = _ini.ataque_dano;
    var _nome_atk = _ini.ataque_nome;
    var _efeito = _ini.ataque_efeito;
    var _chance = _ini.ataque_efeito_chance;
    var _turnos = _ini.ataque_efeito_turnos;
    var _valor_ef = _ini.ataque_efeito_valor;
    var _especial = false;
    var _alvos = [];

    // Ataque especial periódico (ex.: Lama Tóxica da Draga), atinge todo o time
    if (_ini.ataque_especial_turnos > 0 && _ini.contador_turnos mod _ini.ataque_especial_turnos == 0)
    {
        _especial = true;

        _dano = _ini.ataque_especial_dano;
        _nome_atk = _ini.ataque_especial_nome;
        _efeito = _ini.ataque_especial_efeito;
        _chance = _ini.ataque_especial_chance;
        _turnos = _ini.ataque_especial_efeito_turnos;
        _valor_ef = _ini.ataque_especial_efeito_valor;

        _alvos = herois;
    }
    else
    {
        var _alvo_unico = bt_alvo_aleatorio_vivo(herois);

        if (_alvo_unico != noone)
        {
            _alvos = [_alvo_unico];
        }
    }

    bt_animar_ataque(_ini);

    // confuso pelas pegadas do Curupira: pode errar
    if (_ini.confuso > 0)
    {
        _ini.confuso--;

        if (random(100) < 50)
        {
            bt_texto_flutuante(_ini, "ERROU!", make_color_rgb(200, 150, 255));

            mensagem = _ini.nome + " seguiu as pegadas erradas e errou!";

            return;
        }
    }

    var _qtd_efeito = 0;

    for (var i = 0; i < array_length(_alvos); i++)
    {
        var _a = _alvos[i];

        if (!instance_exists(_a) || _a.hp <= 0)
        {
            continue;
        }

        bt_aplicar_efeito(_a, "dano", _dano);

        if (_efeito != "" && _a.hp > 0 && random(100) < _chance)
        {
            if (bt_aplicar_status(_a, _efeito, _turnos, _valor_ef))
            {
                _qtd_efeito++;
            }
        }
    }

    if (_especial)
    {
        mensagem = _ini.nome + " lançou " + _nome_atk + _ini.ataque_especial_texto;
    }
    else if (array_length(_alvos) > 0 && _nome_atk != "")
    {
        mensagem = _ini.nome + " usou " + _nome_atk + " em " + _alvos[0].nome + "!";
    }
    else
    {
        mensagem = _ini.nome + " atacou!";
    }

    if (_qtd_efeito > 0)
    {
        mensagem += " " + bt_texto_efeito(_efeito, _qtd_efeito);
    }
};


// Fim da rodada: fogo e veneno causam dano, escudos perdem 1 turno
fim_da_rodada = function()
{
    var _houve = false;

    for (var lado_i = 0; lado_i < 2; lado_i++)
    {
        var _lista = (lado_i == 0) ? herois : inimigos;

        for (var i = 0; i < array_length(_lista); i++)
        {
            var _c = _lista[i];

            if (!instance_exists(_c) || _c.hp <= 0)
            {
                continue;
            }

            if (_c.dot_turnos > 0)
            {
                bt_aplicar_efeito(_c, "dano", _c.dot_dano);

                _c.flut_cor = (_c.dot_tipo == "veneno") ? make_color_rgb(150, 230, 80) : make_color_rgb(255, 150, 60);

                _c.dot_turnos--;

                if (_c.dot_turnos <= 0)
                {
                    _c.dot_dano = 0;
                }

                _houve = true;
            }

            if (_c.escudo_turnos > 0)
            {
                _c.escudo_turnos--;
            }
        }
    }

    if (_houve)
    {
        mensagem = "Fogo e veneno causaram dano!";
    }

    estado = "fim_rodada";

    timer = 0;
};


// Depois da rodada: derrota, fim da onda ou nova rodada
apos_rodada = function()
{
    limpar_inimigos();

    if (bt_contar_vivos(herois) == 0)
    {
        mensagem = "Derrota!";

        estado = "derrota";

        timer = 0;
    }
    else if (array_length(inimigos) == 0)
    {
        fim_da_onda();
    }
    else
    {
        proximo_heroi(0);
    }
};


// Todos os inimigos da onda caíram
fim_da_onda = function()
{
    if (onda_atual < array_length(ondas) - 1)
    {
        mensagem = "Inimigos derrotados!";

        estado = "transicao_onda";

        timer = 0;

        return;
    }

    // Recompensa só na primeira vez que a lenda é resgatada
    if (recompensa_id >= 0 && !global.personagens[recompensa_id].desbloqueado)
    {
        global.personagem_recompensa = recompensa_id;

        global.personagens[recompensa_id].desbloqueado = true;
    }
    else
    {
        global.personagem_recompensa = -1;
    }

    // Libera a próxima fase
    global.fase_desbloqueada = max(global.fase_desbloqueada, min(global.fase_atual + 1, fases_total()));

    mensagem = "Vitória!";

    estado = "vitoria";

    timer = 0;
};


// ==========================================================
// PRIMEIRA ONDA DE INIMIGOS
// ==========================================================

inimigos = criar_onda(0);


// ==========================================================
// ESTADO DO COMBATE
// ==========================================================

heroi_indice = bt_proximo_vivo(herois, 0);
heroi_atual = herois[heroi_indice];

inimigo_indice = 0;
inimigo_limite = 0;

// Ação escolhida pelo herói da vez, aguardando alvo
acao = bt_ler_acao(heroi_atual, 1);
acao_alvo_cat = "";     // "inimigo" ou "aliado"

estado = "jogador_ataque";

mensagem = heroi_atual.nome + ", escolha um ataque!";

timer = 0;


botao_largura = 250;
botao_altura = 56;

botao1_x = 215;
botao2_x = 495;

botao_y = 440;


// ==========================================================
// PAUSA
// ==========================================================

// Desenha por cima dos combatentes (que desenham no GUI)
depth = -1000;

global.pausado = false;

// "" = menu de pausa, "menu" ou "reiniciar" = pedindo confirmação
pausa_confirmar = "";

// Botão de pausar (canto superior direito)
pausa_btn_x1 = 896;
pausa_btn_y1 = 12;
pausa_btn_x2 = 940;
pausa_btn_y2 = 44;

// Botões do menu de pausa
pausa_btn_largura = 300;
pausa_btn_altura = 52;
pausa_btn_x = 330;

pausa_continuar_y = 218;
pausa_reiniciar_y = 282;
pausa_menu_y = 346;

// Botões da confirmação
pausa_sim_x = 320;
pausa_nao_x = 490;
pausa_conf_y = 332;
pausa_conf_largura = 150;
pausa_conf_altura = 52;


// Congela/retoma a animação de todos os combatentes
congelar_anim = function(_v)
{
    with (obj_combatente)
    {
        image_speed = _v;
    }
};
