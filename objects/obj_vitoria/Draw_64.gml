// ==========================================
// TELA DE VITÓRIA
// ==========================================

ui_begin();

ui_fundo(true, make_color_rgb(8, 22, 12), make_color_rgb(20, 52, 30));
ui_vagalumes(30);
ui_moldura();

ui_painel(230, 90, 730, 450, make_color_rgb(30, 62, 42), global.ui_cor_ouro, 0.95);

var flut = sin(current_time / 700) * 3;

ui_texto(480, 160 + flut, "VITÓRIA!", make_color_rgb(150, 230, 120), global.ui_f_titulo);

ui_divisor(480, 202, 340);

ui_texto(480, 245, "Você derrotou o inimigo!", global.ui_cor_creme, global.ui_f_subtitulo);
ui_texto(480, 285, fase_dados(global.fase_atual).vitoria, make_color_rgb(175, 200, 165), global.ui_f_texto);

ui_botao(
    botao_x,
    botao_y,
    botao_x + botao_largura,
    botao_y + botao_altura,
    "CONTINUAR",
    make_color_rgb(70, 120, 70)
);

ui_fade_in();
ui_fim();
