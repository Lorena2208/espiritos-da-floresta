// ==========================================
// ATALHO DE TESTE: F9 libera todas as fases e lendas
// ==========================================

if (keyboard_check_pressed(vk_f9))
{
    global.fase_desbloqueada = fases_total();

    for (var i = 0; i < array_length(global.personagens); i++)
    {
        global.personagens[i].desbloqueado = true;
    }
}


// ==========================================
// CLIQUE
// ==========================================

if (mouse_check_button_pressed(mb_left))
{
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    // ==========================================
    // FASES
    // ==========================================

    for (var i = 0; i < fases_total(); i++)
    {
        if (
            mx >= cards_x[i] &&
            mx <= cards_x[i] + largura &&
            my >= cards_y[i] &&
            my <= cards_y[i] + altura
        )
        {
            if (i + 1 <= global.fase_desbloqueada)
            {
                global.fase_atual = i + 1;

                room_goto(rm_formacao_equipe);
            }
        }
    }

    // ==========================================
    // VOLTAR
    // ==========================================

    if (
        mx >= botao_voltar_x &&
        mx <= botao_voltar_x + botao_voltar_largura &&
        my >= botao_voltar_y &&
        my <= botao_voltar_y + botao_voltar_altura
    )
    {
        room_goto(rm_menu);
    }
}
