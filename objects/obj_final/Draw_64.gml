// ==========================================
// FIM DE JOGO: A NATUREZA VENCEU
// ==========================================

ui_begin();

draw_sprite_ext(spr_capa_fundo, 0, 0, 0, 1, 1, 0, c_white, 1);

draw_set_alpha(0.55);
draw_set_color(c_black);
draw_rectangle(0, 0, 960, 540, false);
draw_set_alpha(1);

ui_raios(480, 300, 300, 16, global.ui_cor_ouro);
ui_vagalumes(32);
ui_moldura();

var flut = sin(current_time / 700) * 3;

ui_texto(480, 66 + flut, "A NATUREZA VENCEU!", make_color_rgb(150, 230, 120), global.ui_f_titulo);
ui_divisor(480, 100, 420);

ui_texto(480, 128, "O Devorador foi derrotado e as lendas do Brasil protegeram", global.ui_cor_creme, global.ui_f_texto);
ui_texto(480, 150, "as florestas, os rios, o Cerrado, a Mata Atlântica e o Pantanal.", global.ui_cor_creme, global.ui_f_texto);
ui_texto(480, 180, "Mas a luta pela natureza continua - e ela também depende de nós.", make_color_rgb(235, 205, 120), global.ui_f_texto);


// lendas lado a lado
var _n = array_length(sprites_final);
var _esp = 128;
var _x0 = 480 - (_n - 1) * _esp / 2;

for (var i = 0; i < _n; i++)
{
    var _pulo = sin(current_time / 300 + i) * 4;

    draw_sprite_ext(sprites_final[i], current_time / 160, _x0 + i * _esp, 320 + _pulo, 1, 1, 0, c_white, 1);
}

ui_texto(480, 418, "FIM", global.ui_cor_ouro, global.ui_f_subtitulo);

ui_botao(
    botao_x,
    botao_y,
    botao_x + botao_largura,
    botao_y + botao_altura,
    "VOLTAR AO MENU",
    make_color_rgb(70, 120, 70)
);

ui_fade_in();
ui_fim();
