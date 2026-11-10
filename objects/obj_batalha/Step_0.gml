// ==========================================================
// PAUSA
// ==========================================================

var _pode_pausar = (estado != "vitoria" && estado != "derrota");

// Abrir / fechar com ESC ou P

if (_pode_pausar || global.pausado)
{
    if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("P")))
    {
        if (global.pausado && pausa_confirmar != "")
        {
            // ESC dentro da confirmação volta ao menu de pausa
            pausa_confirmar = "";
        }
        else
        {
            global.pausado = !global.pausado;
            pausa_confirmar = "";

            congelar_anim(global.pausado ? 0 : 1);
        }

        exit;
    }
}


// Clique no botão de pausa

if (!global.pausado && _pode_pausar && mouse_check_button_pressed(mb_left))
{
    var _gx = device_mouse_x_to_gui(0);
    var _gy = device_mouse_y_to_gui(0);

    if (
        _gx >= pausa_btn_x1 && _gx <= pausa_btn_x2 &&
        _gy >= pausa_btn_y1 && _gy <= pausa_btn_y2
    )
    {
        global.pausado = true;
        pausa_confirmar = "";

        congelar_anim(0);

        exit;
    }
}


// Jogo pausado: só trata o menu de pausa

if (global.pausado)
{
    if (mouse_check_button_pressed(mb_left))
    {
        var _mx = device_mouse_x_to_gui(0);
        var _my = device_mouse_y_to_gui(0);

        // ---------- CONFIRMAÇÃO ----------

        if (pausa_confirmar != "")
        {
            // SIM
            if (
                _mx >= pausa_sim_x && _mx <= pausa_sim_x + pausa_conf_largura &&
                _my >= pausa_conf_y && _my <= pausa_conf_y + pausa_conf_altura
            )
            {
                var _destino = pausa_confirmar;

                global.pausado = false;

                if (_destino == "menu")
                {
                    room_goto(rm_menu);
                }
                else
                {
                    room_restart();
                }
            }

            // NÃO
            else if (
                _mx >= pausa_nao_x && _mx <= pausa_nao_x + pausa_conf_largura &&
                _my >= pausa_conf_y && _my <= pausa_conf_y + pausa_conf_altura
            )
            {
                pausa_confirmar = "";
            }
        }

        // ---------- MENU DE PAUSA ----------

        else
        {
            // CONTINUAR
            if (
                _mx >= pausa_btn_x && _mx <= pausa_btn_x + pausa_btn_largura &&
                _my >= pausa_continuar_y && _my <= pausa_continuar_y + pausa_btn_altura
            )
            {
                global.pausado = false;

                congelar_anim(1);
            }

            // REINICIAR
            else if (
                _mx >= pausa_btn_x && _mx <= pausa_btn_x + pausa_btn_largura &&
                _my >= pausa_reiniciar_y && _my <= pausa_reiniciar_y + pausa_btn_altura
            )
            {
                pausa_confirmar = "reiniciar";
            }

            // SAIR PARA O MENU
            else if (
                _mx >= pausa_btn_x && _mx <= pausa_btn_x + pausa_btn_largura &&
                _my >= pausa_menu_y && _my <= pausa_menu_y + pausa_btn_altura
            )
            {
                pausa_confirmar = "menu";
            }
        }
    }

    // Nada da batalha avança enquanto pausado
    exit;
}


var _fps = game_get_speed(gamespeed_fps);


// ==========================================================
// TURNO DO JOGADOR: ESCOLHER ATAQUE (clique ou teclas 1 / 2)
// ==========================================================

if (estado == "jogador_ataque")
{
    var _escolhido = 0;

    if (mouse_check_button_pressed(mb_left))
    {
        if (point_in_rectangle(mouse_x, mouse_y, botao1_x, botao_y, botao1_x + botao_largura, botao_y + botao_altura))
        {
            _escolhido = 1;
        }
        else if (point_in_rectangle(mouse_x, mouse_y, botao2_x, botao_y, botao2_x + botao_largura, botao_y + botao_altura))
        {
            _escolhido = 2;
        }
    }

    if (keyboard_check_pressed(ord("1")))
    {
        _escolhido = 1;
    }
    else if (keyboard_check_pressed(ord("2")))
    {
        _escolhido = 2;
    }

    if (_escolhido != 0)
    {
        acao = bt_ler_acao(heroi_atual, _escolhido);

        if (acao.alvo == "inimigo_um")
        {
            acao_alvo_cat = "inimigo";

            estado = "jogador_alvo";

            mensagem = "Escolha o inimigo a atacar!";
        }
        else if (acao.alvo == "aliado_um")
        {
            acao_alvo_cat = "aliado";

            estado = "jogador_alvo";

            mensagem = (acao.tipo == "cura") ? "Escolha quem vai curar!" : "Escolha um aliado!";
        }
        else if (acao.alvo == "inimigo_todos")
        {
            executar_acao(inimigos);
        }
        else
        {
            executar_acao(herois);
        }
    }
}


// ==========================================================
// TURNO DO JOGADOR: ESCOLHER ALVO
// ==========================================================

else if (estado == "jogador_alvo")
{
    if (mouse_check_button_pressed(mb_left))
    {
        // Cancelar e voltar a escolher o ataque
        if (point_in_rectangle(mouse_x, mouse_y, botao1_x, botao_y, botao2_x + botao_largura, botao_y + botao_altura))
        {
            estado = "jogador_ataque";

            mensagem = heroi_atual.nome + ", escolha um ataque!";
        }
        else
        {
            var _lista = (acao_alvo_cat == "inimigo") ? inimigos : herois;

            for (var i = 0; i < array_length(_lista); i++)
            {
                var _t = _lista[i];

                if (
                    instance_exists(_t) && _t.hp > 0 &&
                    point_in_rectangle(mouse_x, mouse_y, _t.bbox_left, _t.bbox_top, _t.bbox_right, _t.bbox_bottom)
                )
                {
                    executar_acao([_t]);

                    break;
                }
            }
        }
    }
    else if (mouse_check_button_pressed(mb_right))
    {
        estado = "jogador_ataque";

        mensagem = heroi_atual.nome + ", escolha um ataque!";
    }
}


// ==========================================================
// VERIFICAR RESULTADO DA AÇÃO DO JOGADOR
// ==========================================================

if (estado == "verificar_acao")
{
    timer++;

    if (timer >= _fps)
    {
        timer = 0;

        limpar_inimigos();

        if (array_length(inimigos) == 0)
        {
            fim_da_onda();
        }
        else
        {
            proximo_heroi(heroi_indice + 1);
        }
    }
}


// ==========================================================
// HERÓI PRESO (atordoado): perde a vez
// ==========================================================

if (estado == "heroi_atordoado")
{
    timer++;

    if (timer >= _fps)
    {
        timer = 0;

        proximo_heroi(heroi_indice + 1);
    }
}


// ==========================================================
// TRANSIÇÃO PARA A PRÓXIMA ONDA
// ==========================================================

if (estado == "transicao_onda")
{
    timer++;

    if (timer >= _fps * 2)
    {
        timer = 0;

        onda_atual++;

        inimigos = criar_onda(onda_atual);

        var _nomes = inimigos[0].nome;

        for (var i = 1; i < array_length(inimigos); i++)
        {
            _nomes += ((i == array_length(inimigos) - 1) ? " e " : ", ") + inimigos[i].nome;
        }

        mensagem = _nomes + ((array_length(inimigos) > 1) ? " apareceram!" : " apareceu!");

        estado = "entrada_onda";

        timer = 0;
    }
}


// ==========================================================
// ENTRADA DA NOVA ONDA (pausa dramática)
// ==========================================================

if (estado == "entrada_onda")
{
    timer++;

    if (timer >= _fps * 1.5)
    {
        timer = 0;

        proximo_heroi(0);
    }
}


// ==========================================================
// TURNO DOS INIMIGOS
// ==========================================================

if (estado == "turno_inimigos")
{
    timer++;

    if (timer >= _fps)
    {
        timer = 0;

        // Pula inimigos que já morreram nesta mesma rodada
        while (
            inimigo_indice < inimigo_limite &&
            inimigo_indice < array_length(inimigos) &&
            (!instance_exists(inimigos[inimigo_indice]) || inimigos[inimigo_indice].hp <= 0)
        )
        {
            inimigo_indice++;
        }

        if (inimigo_indice >= inimigo_limite || inimigo_indice >= array_length(inimigos) || bt_contar_vivos(herois) == 0)
        {
            fim_da_rodada();
        }
        else
        {
            var _ini = inimigos[inimigo_indice];

            inimigo_indice++;

            acao_inimigo(_ini);
        }
    }
}


// ==========================================================
// FIM DA RODADA (fogo, veneno e escudos)
// ==========================================================

if (estado == "fim_rodada")
{
    timer++;

    if (timer >= _fps)
    {
        timer = 0;

        apos_rodada();
    }
}


// ==========================================================
// VITÓRIA
// ==========================================================

if (estado == "vitoria")
{
    timer++;

    if (timer >= _fps)
    {
        if (global.personagem_recompensa != -1)
        {
            room_goto(rm_recompensa);
        }
        else if (global.fase_atual >= fases_total())
        {
            room_goto(rm_final);
        }
        else
        {
            room_goto(rm_vitoria);
        }
    }
}


// ==========================================================
// DERROTA
// ==========================================================

if (estado == "derrota")
{
    timer++;

    if (timer >= _fps)
    {
        room_goto(rm_derrota);
    }
}
