// ==========================================
// TELA DE DERROTA
// ==========================================

ui_begin();

ui_fundo(true, make_color_rgb(22, 8, 8), make_color_rgb(46, 20, 20));
ui_moldura();

ui_painel(230, 60, 730, 506, make_color_rgb(58, 28, 28), global.ui_cor_ouro, 0.95);

ui_texto(480, 112, "DERROTA", make_color_rgb(230, 95, 85), global.ui_f_titulo);

ui_divisor(480, 152, 340);

ui_texto(480, 190, "Você foi derrotado...", global.ui_cor_creme, global.ui_f_subtitulo);
ui_texto(480, 224, "Mas a lenda ainda não terminou.", make_color_rgb(200, 170, 165), global.ui_f_texto);
ui_texto(480, 262, dica, make_color_rgb(235, 205, 120), global.ui_f_pequeno);

ui_botao(
    botao_tentar_x,
    botao_tentar_y,
    botao_tentar_x + botao_largura,
    botao_tentar_y + botao_altura,
    "TENTAR NOVAMENTE",
    make_color_rgb(130, 70, 70)
);

ui_botao(
    botao_equipe_x,
    botao_equipe_y,
    botao_equipe_x + botao_largura,
    botao_equipe_y + botao_altura,
    "TROCAR EQUIPE",
    make_color_rgb(70, 100, 70)
);

ui_botao(
    botao_menu_x,
    botao_menu_y,
    botao_menu_x + botao_largura,
    botao_menu_y + botao_altura,
    "VOLTAR AO MENU",
    make_color_rgb(70, 70, 100)
);

ui_fade_in();
ui_fim();
