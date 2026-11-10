// ==========================================
// MOUSE
// ==========================================

if (mouse_check_button_pressed(mb_left))
{
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    // ==========================================
    // JOGAR
    // ==========================================

    if (
        mx >= botao_x &&
        mx <= botao_x + botao_largura &&
        my >= botao_jogar_y &&
        my <= botao_jogar_y + botao_altura
    )
    {
        room_goto(rm_selecao_fases);
    }

    // ==========================================
    // ENCICLOPÉDIA
    // ==========================================

    if (
        mx >= botao_x &&
        mx <= botao_x + botao_largura &&
        my >= botao_enciclopedia_y &&
        my <= botao_enciclopedia_y + botao_altura
    )
    {
        room_goto(rm_enciclopedia);
    }

    // ==========================================
    // SAIR
    // ==========================================

    if (
        mx >= botao_x &&
        mx <= botao_x + botao_largura &&
        my >= botao_sair_y &&
        my <= botao_sair_y + botao_altura
    )
    {
        game_end();
    }
}