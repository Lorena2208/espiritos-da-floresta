// ==========================================================
// SCR_BATALHA - Funções auxiliares do combate em equipe
// ==========================================================


// Retorna o índice do próximo combatente vivo na lista,
// começando em _inicio (inclusive). -1 se não houver nenhum.
function bt_proximo_vivo(_lista, _inicio)
{
    for (var i = _inicio; i < array_length(_lista); i++)
    {
        var _c = _lista[i];

        if (instance_exists(_c) && _c.hp > 0)
        {
            return i;
        }
    }

    return -1;
}


// Quantos combatentes da lista ainda estão vivos
function bt_contar_vivos(_lista)
{
    var _n = 0;

    for (var i = 0; i < array_length(_lista); i++)
    {
        var _c = _lista[i];

        if (instance_exists(_c) && _c.hp > 0)
        {
            _n++;
        }
    }

    return _n;
}


// Um combatente vivo aleatório da lista (noone se não houver)
function bt_alvo_aleatorio_vivo(_lista)
{
    var _vivos = [];

    for (var i = 0; i < array_length(_lista); i++)
    {
        var _c = _lista[i];

        if (instance_exists(_c) && _c.hp > 0)
        {
            array_push(_vivos, _c);
        }
    }

    if (array_length(_vivos) == 0)
    {
        return noone;
    }

    return _vivos[irandom(array_length(_vivos) - 1)];
}


// Aplica dano, cura ou escudo a UM alvo e dispara a animação/efeito visual.
// O escudo (Curupira) reduz o dano recebido pela metade.
// Retorna o valor que realmente foi aplicado.
function bt_aplicar_efeito(_alvo, _tipo, _valor)
{
    if (!instance_exists(_alvo) || _alvo.hp <= 0)
    {
        return 0;
    }

    var _efetivo = _valor;

    if (_tipo == "cura")
    {
        var _antes = _alvo.hp;

        _alvo.hp = min(_alvo.hp_max, _alvo.hp + _valor);

        _efetivo = _alvo.hp - _antes;

        _alvo.dano_recebido = _efetivo;
        _alvo.flut_texto = "+" + string(_efetivo);
        _alvo.flut_cor = make_color_rgb(130, 235, 150);
    }
    else if (_tipo == "escudo")
    {
        _efetivo = 0;

        _alvo.dano_recebido = 0;
        _alvo.flut_texto = "ESCUDO";
        _alvo.flut_cor = make_color_rgb(140, 200, 255);
    }
    else
    {
        if (_alvo.escudo_turnos > 0)
        {
            _efetivo = max(1, round(_valor * 0.5));
        }

        _alvo.hp = max(0, _alvo.hp - _efetivo);

        _alvo.dano_recebido = _efetivo;
        _alvo.flut_texto = "-" + string(_efetivo);
        _alvo.flut_cor = make_color_rgb(255, 95, 70);
    }

    _alvo.tipo_efeito = _tipo;

    _alvo.animacao_combate = (_tipo == "dano") ? "dano" : "normal";
    _alvo.animacao_timer = 0;

    _alvo.efeito_dano = true;
    _alvo.efeito_dano_timer = 15;

    _alvo.dano_timer = game_get_speed(gamespeed_fps);

    return _efetivo;
}


// Mostra um texto flutuante sobre o combatente (ex.: "ERROU!")
function bt_texto_flutuante(_alvo, _texto, _cor)
{
    if (!instance_exists(_alvo))
    {
        return;
    }

    _alvo.flut_texto = _texto;
    _alvo.flut_cor = _cor;
    _alvo.dano_timer = game_get_speed(gamespeed_fps);
}


// Aplica um efeito de status. Retorna true se algo mudou.
//   "atordoar"  -> perde a próxima vez
//   "confundir" -> 50% de chance de errar o ataque
//   "queimar"   -> dano de fogo no fim de cada rodada
//   "envenenar" -> dano de veneno no fim de cada rodada
//   "escudo"    -> recebe metade do dano
//   "purificar" -> remove fogo e veneno
function bt_aplicar_status(_alvo, _efeito, _turnos, _valor)
{
    if (!instance_exists(_alvo) || _alvo.hp <= 0)
    {
        return false;
    }

    switch (_efeito)
    {
        case "atordoar":
            _alvo.atordoado = max(_alvo.atordoado, _turnos);
            return true;

        case "confundir":
            _alvo.confuso = max(_alvo.confuso, _turnos);
            return true;

        case "queimar":
            _alvo.dot_turnos = max(_alvo.dot_turnos, _turnos);
            _alvo.dot_dano = max(_alvo.dot_dano, _valor);
            _alvo.dot_tipo = "fogo";
            return true;

        case "envenenar":
            _alvo.dot_turnos = max(_alvo.dot_turnos, _turnos);
            _alvo.dot_dano = max(_alvo.dot_dano, _valor);
            _alvo.dot_tipo = "veneno";
            return true;

        case "escudo":
            _alvo.escudo_turnos = max(_alvo.escudo_turnos, _turnos);
            return true;

        case "purificar":
            if (_alvo.dot_turnos > 0)
            {
                _alvo.dot_turnos = 0;
                _alvo.dot_dano = 0;
                return true;
            }
            return false;
    }

    return false;
}


// Frase curta que complementa a mensagem quando um efeito pega
function bt_texto_efeito(_efeito, _qtd)
{
    switch (_efeito)
    {
        case "atordoar":  return (_qtd > 1) ? "Atordoou " + string(_qtd) + "!" : "Atordoado!";
        case "confundir": return "Ficou confuso!";
        case "queimar":   return "Está queimando!";
        case "envenenar": return "Envenenado!";
        case "escudo":    return "Escudo ativo!";
        case "purificar": return "Fogo e veneno removidos!";
    }

    return "";
}


// Texto curto que aparece embaixo do nome do ataque no botão
function bt_descricao_ataque(_tipo, _valor, _alvo, _efeito, _chance)
{
    var _txt = "";

    if (_tipo == "cura")
    {
        _txt = "Cura " + string(_valor);
    }
    else if (_tipo == "escudo")
    {
        _txt = "Escudo -50% dano";
    }
    else
    {
        _txt = "Dano " + string(_valor);
    }

    if (_alvo == "inimigo_todos" || _alvo == "aliado_todos")
    {
        _txt += " em todos";
    }

    switch (_efeito)
    {
        case "queimar":   _txt += " + fogo"; break;
        case "envenenar": _txt += " + veneno"; break;
        case "atordoar":  _txt += " + atordoa"; break;
        case "confundir": _txt += " + confunde"; break;
        case "purificar": _txt += " + limpa"; break;
    }

    if (_efeito != "" && _efeito != "escudo" && _chance < 100)
    {
        _txt += " (" + string(_chance) + "%)";
    }

    return _txt;
}


// Lê o ataque 1 ou 2 de um herói como struct
function bt_ler_acao(_heroi, _n)
{
    if (_n == 1)
    {
        return {
            nome: _heroi.ataque1_nome,
            tipo: _heroi.ataque1_tipo,
            alvo: _heroi.ataque1_alvo,
            valor: _heroi.ataque1_valor,
            efeito: _heroi.ataque1_efeito,
            chance: _heroi.ataque1_chance,
            turnos: _heroi.ataque1_turnos,
            efeito_valor: _heroi.ataque1_efeito_valor
        };
    }

    return {
        nome: _heroi.ataque2_nome,
        tipo: _heroi.ataque2_tipo,
        alvo: _heroi.ataque2_alvo,
        valor: _heroi.ataque2_valor,
        efeito: _heroi.ataque2_efeito,
        chance: _heroi.ataque2_chance,
        turnos: _heroi.ataque2_turnos,
        efeito_valor: _heroi.ataque2_efeito_valor
    };
}


// Dispara a animação de ataque de quem está agindo
function bt_animar_ataque(_atacante)
{
    if (!instance_exists(_atacante))
    {
        return;
    }

    _atacante.animacao_combate = "ataque";
    _atacante.animacao_timer = 0;
}


// ==========================================================
// POSICIONAMENTO
// ==========================================================

// Até 3 heróis: formação original. 4 heróis: duas colunas.
function bt_posicoes_herois(_n)
{
    if (_n >= 4)
    {
        return [
            { x: 300, y: 322 },
            { x: 140, y: 306 },
            { x: 300, y: 162 },
            { x: 140, y: 146 }
        ];
    }

    return [
        { x: 230, y: 300 },
        { x: 175, y: 215 },
        { x: 222, y: 136 }
    ];
}


// Posições automáticas dos inimigos comuns (lado direito)
function bt_posicoes_inimigos(_n)
{
    switch (_n)
    {
        case 1:
            return [ { x: 700, y: 250 } ];

        case 2:
            return [ { x: 640, y: 300 }, { x: 800, y: 200 } ];

        case 3:
            return [ { x: 650, y: 322 }, { x: 830, y: 322 }, { x: 740, y: 162 } ];
    }

    return [
        { x: 650, y: 322 },
        { x: 830, y: 306 },
        { x: 650, y: 162 },
        { x: 830, y: 146 }
    ];
}


// Ajusta um combatente recém-posicionado para a batalha
function bt_preparar(_c, _lado, _compacto)
{
    if (!instance_exists(_c))
    {
        return;
    }

    _c.lado = _lado;
    _c.x_original = _c.x;
    _c.y_original = _c.y;
    _c.dir_ataque = (_lado == "heroi") ? 1 : -1;
    _c.hud_compacto = _compacto;
    _c.hud_altura = (_lado == "heroi") ? 120 : 128;
    _c.hp_visual = _c.hp;

    // quem está mais embaixo é desenhado na frente
    _c.depth = -round(_c.y);
}


// ==========================================================
// INTERFACE DO COMBATENTE (placa, status e números)
// ==========================================================

function bt_desenhar_hud(_c, _destaque)
{
    if (!instance_exists(_c) || _c.morrendo)
    {
        return;
    }

    ui_init();

    // barra de vida com "rastro" suave
    _c.hp_visual = lerp(_c.hp_visual, _c.hp, 0.08);

    if (abs(_c.hp_visual - _c.hp) < 0.5)
    {
        _c.hp_visual = _c.hp;
    }

    var _cx = _c.x_original;
    var _y = _c.y_original - _c.hud_altura;
    var _larg = 130;
    var _alt = 52;
    var _num_y = _c.y_original - ((_c.lado == "heroi") ? 10 : 20);

    if (_c.eh_chefe)
    {
        _cx = _c.x_original + _c.hud_chefe_dx;
        _y = _c.hud_chefe_y;
        _larg = _c.hud_chefe_larg;
        _num_y = _y + 120;
    }
    else if (_c.hud_compacto)
    {
        _y = _c.y_original - 104;
        _larg = 112;
        _alt = 36;
    }

    // seta indicando de quem é a vez
    if (_destaque)
    {
        var _b = sin(current_time / 160) * 3;

        draw_set_color(global.ui_cor_ouro_vivo);
        draw_triangle(_cx - 9, _y - 16 + _b, _cx + 9, _y - 16 + _b, _cx, _y - 5 + _b, false);
    }

    if (_alt == 36)
    {
        ui_hud_compacto(_cx, _y, _c.nome, _c.hp, _c.hp_visual, _c.hp_max, _larg);
    }
    else
    {
        ui_hud_combatente(_cx, _y, _c.nome, _c.hp, _c.hp_visual, _c.hp_max, _larg);
    }

    ui_status(_cx, _y + _alt + 11, _c);

    if (_c.dano_timer > 0)
    {
        ui_numero_flutuante(_cx, _num_y, _c.flut_texto, _c.flut_cor, _c.dano_timer, game_get_speed(gamespeed_fps));
    }
}
