if (mouse_check_button_pressed(mb_left))
{
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    // ==========================================
    // SE ESTAMOS NO ÁLBUM
    // ==========================================

    if (personagem_selecionado == -1)
    {
        var _n = min(array_length(global.personagens), array_length(cards_x));
        var _clicou = -1;

        for (var i = 0; i < _n; i++)
        {
            if (
                mx >= cards_x[i] &&
                mx <= cards_x[i] + card_largura &&
                my >= cards_y[i] &&
                my <= cards_y[i] + card_altura
            )
            {
                _clicou = i;
            }
        }

        if (_clicou != -1)
        {
            personagem_selecionado = _clicou;
        }

        // ==========================================
        // VOLTAR PARA O MENU
        // ==========================================

        else if (
            mx >= botao_voltar_x &&
            mx <= botao_voltar_x + botao_voltar_largura &&
            my >= botao_voltar_y &&
            my <= botao_voltar_y + botao_voltar_altura
        )
        {
            room_goto(rm_menu);
        }
    }

    // ==========================================
    // SE ESTAMOS NA PÁGINA DO PERSONAGEM
    // ==========================================

    else
    {
        if (
            mx >= voltar_pg_x1 &&
            mx <= voltar_pg_x2 &&
            my >= voltar_pg_y1 &&
            my <= voltar_pg_y2
        )
        {
            personagem_selecionado = -1;
        }
    }
}
