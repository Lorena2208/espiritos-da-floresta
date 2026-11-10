// ==========================================
// MENU PRINCIPAL
// ==========================================

ui_begin();

// Capa do jogo como fundo
draw_sprite_ext(spr_capa_fundo, 0, 0, 0, 1, 1, 0, c_white, 1);

// leve escurecimento geral para destacar os botões
draw_set_alpha(0.25);
draw_set_color(c_black);
draw_rectangle(0, 0, 960, 540, false);
draw_set_alpha(1);

ui_vagalumes(24);
ui_moldura();


// ==========================================
// TÍTULO (logotipo da capa)
// ==========================================

var flut = sin(current_time / 800) * 3;

draw_sprite_ext(spr_logo, 0, 480, 112 + flut, 1, 1, 0, c_white, 1);


// ==========================================
// BOTÕES
// ==========================================

ui_painel(318, 240, 642, 488, make_color_rgb(12, 24, 18), global.ui_cor_ouro, 0.72);

ui_botao(
    botao_x,
    botao_jogar_y,
    botao_x + botao_largura,
    botao_jogar_y + botao_altura,
    "JOGAR",
    make_color_rgb(49, 92, 64)
);

ui_botao(
    botao_x,
    botao_enciclopedia_y,
    botao_x + botao_largura,
    botao_enciclopedia_y + botao_altura,
    "ENCICLOPÉDIA",
    make_color_rgb(91, 69, 42)
);

ui_botao(
    botao_x,
    botao_sair_y,
    botao_x + botao_largura,
    botao_sair_y + botao_altura,
    "SAIR",
    make_color_rgb(80, 45, 40)
);


// ==========================================
// RODAPÉ
// ==========================================

ui_texto(480, 503, "Lendas e criaturas do folclore brasileiro", make_color_rgb(190, 200, 170), global.ui_f_pequeno);

ui_fade_in();
ui_fim();
