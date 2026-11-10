
if (mouse_check_button_pressed(mb_left))
{
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    if (mx >= botao_tentar_x &&
        mx <= botao_tentar_x + botao_largura &&
        my >= botao_tentar_y &&
        my <= botao_tentar_y + botao_altura)
    {
        room_goto(fase_dados(global.fase_atual).sala);
    }

    if (mx >= botao_equipe_x &&
        mx <= botao_equipe_x + botao_largura &&
        my >= botao_equipe_y &&
        my <= botao_equipe_y + botao_altura)
    {
        room_goto(rm_formacao_equipe);
    }

    if (mx >= botao_menu_x &&
        mx <= botao_menu_x + botao_largura &&
        my >= botao_menu_y &&
        my <= botao_menu_y + botao_altura)
    {
        room_goto(rm_menu);
    }
}
