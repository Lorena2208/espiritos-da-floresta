// ==========================================
// DESENHO DO COMBATENTE (a placa de vida, os
// status e os números são desenhados pela batalha)
// ==========================================

if (!visible)
{
    exit;
}

ui_init();

var _alpha = image_alpha;
var _cor = c_white;

// herói caído fica apagado
if (lado == "heroi" && hp <= 0)
{
    _alpha = image_alpha * 0.35;
    _cor = make_color_rgb(120, 120, 135);
}

if (furia)
{
    _cor = make_color_rgb(255, 150, 140);
}

var _cx = (bbox_left + bbox_right) / 2;
var _cy = (bbox_top + bbox_bottom) / 2;


// sombra no chão
if (sombra)
{
    var _sw = (bbox_right - bbox_left) * 0.36;

    draw_set_alpha(0.28 * _alpha);
    draw_set_color(c_black);
    draw_ellipse(_cx - _sw, bbox_bottom - 7, _cx + _sw, bbox_bottom + 3, false);
    draw_set_alpha(1);
}


// bolha do escudo (atrás)
if (escudo_turnos > 0 && hp > 0)
{
    var _r = max(bbox_right - bbox_left, bbox_bottom - bbox_top) * 0.55;
    var _p = 0.5 + 0.5 * sin(current_time / 250);

    draw_set_alpha(0.12 + 0.06 * _p);
    draw_set_color(make_color_rgb(90, 170, 255));
    draw_circle(_cx, _cy, _r, false);
    draw_set_alpha(0.5);
    draw_circle(_cx, _cy, _r, true);
    draw_set_alpha(1);
}


// sprite (pisca claro ao receber dano)
if (efeito_dano)
{
    gpu_set_blendmode(bm_add);

    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, _alpha);

    gpu_set_blendmode(bm_normal);
}
else
{
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, _cor, _alpha);
}


// queimando / envenenado: brilho piscando por cima
if (dot_turnos > 0 && hp > 0)
{
    var _pulso = 0.15 + 0.12 * sin(current_time / 120);
    var _dot_cor = (dot_tipo == "veneno") ? make_color_rgb(120, 255, 60) : make_color_rgb(255, 110, 30);

    gpu_set_blendmode(bm_add);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, _dot_cor, _pulso * _alpha);
    gpu_set_blendmode(bm_normal);
}


// atordoado: estrelinhas girando sobre a cabeça
if (atordoado > 0 && hp > 0)
{
    var _t = current_time / 260;

    for (var i = 0; i < 3; i++)
    {
        var _a = _t + i * 2.09;
        var _sx = _cx + cos(_a) * 18;
        var _sy = bbox_top + 4 + sin(_a) * 5;

        draw_set_color(make_color_rgb(255, 230, 90));
        draw_circle(_sx, _sy, 3, false);
        draw_set_color(c_white);
        draw_circle(_sx, _sy, 1, false);
    }
}


// confuso: pontos de interrogação roxos
if (confuso > 0 && hp > 0)
{
    var _b = sin(current_time / 200) * 3;

    ui_texto(_cx - 10, bbox_top + 2 + _b, "?", make_color_rgb(200, 140, 255), global.ui_f_botao);
    ui_texto(_cx + 10, bbox_top - 4 - _b, "?", make_color_rgb(200, 140, 255), global.ui_f_botao);
}

ui_reset();
