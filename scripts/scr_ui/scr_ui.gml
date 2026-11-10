// ==========================================================
// SCR_UI - Sistema de interface do jogo
// Funcoes reutilizaveis: fundo, molduras, paineis, botoes,
// barras de vida, textos, etiquetas e efeitos.
// Todas as telas usam estas funcoes para manter o mesmo visual.
// ==========================================================


// ==========================================================
// INICIALIZACAO (paleta + fontes)
// ==========================================================

function ui_init()
{
    if (variable_global_exists("ui_pronto"))
    {
        return;
    }

    global.ui_pronto = true;

    // Paleta
    global.ui_cor_ouro      = make_color_rgb(220, 190, 115);
    global.ui_cor_ouro_vivo = make_color_rgb(255, 232, 150);
    global.ui_cor_creme     = make_color_rgb(235, 225, 190);
    global.ui_cor_fundo     = make_color_rgb(18, 35, 27);
    global.ui_cor_sombra    = make_color_rgb(6, 12, 9);
    global.ui_cor_pergaminho = make_color_rgb(205, 184, 138);
    global.ui_cor_tinta     = make_color_rgb(40, 45, 30);

    // Fontes (se o asset nao existir, usa a fonte padrao = -1)
    global.ui_f_titulo    = asset_get_index("fnt_titulo");
    global.ui_f_subtitulo = asset_get_index("fnt_subtitulo");
    global.ui_f_botao     = asset_get_index("fnt_botao");
    global.ui_f_texto     = asset_get_index("fnt_texto");
    global.ui_f_pequeno   = asset_get_index("fnt_pequeno");

    global.ui_hover_frame = false;
}


// Chamar no INICIO de todo Draw GUI que usa a UI
function ui_begin()
{
    ui_init();

    global.ui_hover_frame = false;

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_font(global.ui_f_texto);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
}


// Restaura o estado de desenho
function ui_reset()
{
    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_font(-1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}


// Chamar no FIM: ajusta o cursor (mao sobre botoes) e restaura o estado
function ui_fim()
{
    if (variable_global_exists("ui_hover_frame"))
    {
        window_set_cursor(global.ui_hover_frame ? cr_handpoint : cr_default);
    }

    ui_reset();
}


// ==========================================================
// MOUSE
// ==========================================================

function ui_mouse_sobre(_x1, _y1, _x2, _y2)
{
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    return (mx >= _x1 && mx <= _x2 && my >= _y1 && my <= _y2);
}


// ==========================================================
// TEXTO
// ==========================================================

// Texto com opcao de sombra e alinhamento
function ui_texto_ex(_x, _y, _texto, _cor, _fonte, _halign, _valign, _sombra)
{
    ui_init();

    var a = draw_get_alpha();

    draw_set_font(_fonte);
    draw_set_halign(_halign);
    draw_set_valign(_valign);

    if (_sombra)
    {
        draw_set_alpha(a * 0.85);
        draw_set_color(global.ui_cor_sombra);
        draw_text(_x + 2, _y + 2, _texto);
        draw_set_alpha(a);
    }

    draw_set_color(_cor);
    draw_text(_x, _y, _texto);
}


// Centralizado, com sombra
function ui_texto(_x, _y, _texto, _cor, _fonte)
{
    ui_texto_ex(_x, _y, _texto, _cor, _fonte, fa_center, fa_middle, true);
}


// Alinhado a esquerda, com sombra
function ui_texto_esq(_x, _y, _texto, _cor, _fonte)
{
    ui_texto_ex(_x, _y, _texto, _cor, _fonte, fa_left, fa_middle, true);
}


// Centralizado, sem sombra (para fundos claros)
function ui_texto_liso(_x, _y, _texto, _cor, _fonte)
{
    ui_texto_ex(_x, _y, _texto, _cor, _fonte, fa_center, fa_middle, false);
}


// Paragrafo com quebra automatica de linha
function ui_paragrafo(_x, _y, _texto, _cor, _fonte, _largura, _altura_linha)
{
    ui_init();

    var a = draw_get_alpha();

    draw_set_font(_fonte);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    draw_set_alpha(a * 0.8);
    draw_set_color(global.ui_cor_sombra);
    draw_text_ext(_x + 1, _y + 1, _texto, _altura_linha, _largura);

    draw_set_alpha(a);
    draw_set_color(_cor);
    draw_text_ext(_x, _y, _texto, _altura_linha, _largura);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
}


// Titulo de tela (flutua levemente)
function ui_titulo(_y, _texto)
{
    ui_init();

    var flut = sin(current_time / 900) * 2;

    ui_texto(480, _y + flut, _texto, global.ui_cor_ouro, global.ui_f_titulo);
}


// ==========================================================
// FORMAS E DECORACAO
// ==========================================================

function ui_losango(_x, _y, _r, _cor)
{
    draw_set_color(_cor);

    draw_triangle(_x, _y - _r, _x + _r, _y, _x, _y + _r, false);
    draw_triangle(_x, _y - _r, _x - _r, _y, _x, _y + _r, false);
}


// Linha decorativa com losango no centro
function ui_divisor(_x, _y, _largura)
{
    ui_init();

    var a = draw_get_alpha();

    draw_set_color(global.ui_cor_ouro);
    draw_set_alpha(a * 0.7);

    draw_line(_x - _largura / 2, _y, _x - 10, _y);
    draw_line(_x + 10, _y, _x + _largura / 2, _y);

    draw_set_alpha(a);

    ui_losango(_x, _y, 5, global.ui_cor_ouro);
    ui_losango(_x - _largura / 2, _y, 3, global.ui_cor_ouro);
    ui_losango(_x + _largura / 2, _y, 3, global.ui_cor_ouro);
}


// Moldura dourada da tela (960x540)
function ui_moldura()
{
    ui_init();

    var o = global.ui_cor_ouro;

    draw_set_alpha(1);
    draw_set_color(o);

    draw_rectangle(24, 24, 936, 516, true);
    draw_rectangle(25, 25, 935, 515, true);

    draw_set_alpha(0.45);
    draw_rectangle(33, 33, 927, 507, true);
    draw_set_alpha(1);

    ui_losango(25, 25, 8, o);
    ui_losango(935, 25, 8, o);
    ui_losango(25, 515, 8, o);
    ui_losango(935, 515, 8, o);
}


// Painel com sombra, leve degrade e borda dupla
function ui_painel(_x1, _y1, _x2, _y2, _cor, _borda, _alpha = 1)
{
    ui_init();

    // sombra
    draw_set_color(global.ui_cor_sombra);
    draw_set_alpha(0.45 * _alpha);
    draw_rectangle(_x1 + 4, _y1 + 5, _x2 + 4, _y2 + 5, false);

    // corpo
    var topo = merge_color(_cor, c_white, 0.08);
    var base = merge_color(_cor, c_black, 0.25);

    draw_set_alpha(_alpha);
    draw_rectangle_color(_x1, _y1, _x2, _y2, topo, topo, base, base, false);

    // bordas
    draw_set_color(_borda);
    draw_rectangle(_x1, _y1, _x2, _y2, true);

    draw_set_alpha(_alpha * 0.35);
    draw_rectangle(_x1 + 3, _y1 + 3, _x2 - 3, _y2 - 3, true);

    draw_set_alpha(1);
}


// Etiqueta (pilula) com texto. Retorna a largura.
function ui_etiqueta(_cx, _cy, _texto, _cor_fundo, _cor_texto, _fonte)
{
    ui_init();

    draw_set_font(_fonte);

    var w = string_width(_texto) + 22;
    var h = string_height(_texto) + 8;

    draw_set_color(_cor_fundo);
    draw_roundrect_ext(_cx - w / 2, _cy - h / 2, _cx + w / 2, _cy + h / 2, 10, 10, false);

    draw_set_color(merge_color(_cor_fundo, c_white, 0.45));
    draw_roundrect_ext(_cx - w / 2, _cy - h / 2, _cx + w / 2, _cy + h / 2, 10, 10, true);

    ui_texto_liso(_cx, _cy, _texto, _cor_texto, _fonte);

    return w;
}


// Cor associada a funcao do personagem
function ui_cor_funcao(_funcao)
{
    if (_funcao == "DPS")
    {
        return make_color_rgb(150, 60, 50);
    }
    else if (_funcao == "SUPORTE")
    {
        return make_color_rgb(45, 110, 130);
    }
    else if (_funcao == "AOE")
    {
        return make_color_rgb(110, 75, 130);
    }
    else if (_funcao == "QUEIMADURA")
    {
        return make_color_rgb(170, 80, 35);
    }
    else if (_funcao == "CONTROLE")
    {
        return make_color_rgb(150, 50, 70);
    }
    else if (_funcao == "TANQUE")
    {
        return make_color_rgb(60, 110, 60);
    }

    return make_color_rgb(140, 95, 45);
}


// Cadeado desenhado com formas simples
function ui_cadeado(_cx, _cy, _cor)
{
    draw_set_alpha(1);
    draw_set_color(_cor);

    // argola
    draw_circle(_cx, _cy - 2, 9, true);
    draw_circle(_cx, _cy - 2, 8, true);

    // corpo
    draw_rectangle(_cx - 14, _cy - 2, _cx + 14, _cy + 20, false);

    // buraco da chave
    draw_set_color(global.ui_cor_sombra);
    draw_circle(_cx, _cy + 7, 3, false);
    draw_rectangle(_cx - 1, _cy + 8, _cx + 1, _cy + 14, false);
}


// ==========================================================
// FUNDO E EFEITOS
// ==========================================================

// Fundo da tela: floresta escurecida + degrade
function ui_fundo(_usar_imagem = true, _cor_escura = -1, _cor_media = -1)
{
    ui_init();

    var c1 = _cor_escura;
    var c2 = _cor_media;

    if (c1 == -1) c1 = make_color_rgb(8, 18, 13);
    if (c2 == -1) c2 = make_color_rgb(18, 42, 30);

    draw_set_alpha(1);
    draw_set_color(global.ui_cor_fundo);
    draw_rectangle(0, 0, 960, 540, false);

    if (_usar_imagem)
    {
        draw_sprite_ext(spr_fundo_floresta, 0, 0, -90, 1, 1, 0, c_white, 0.32);
    }

    draw_set_alpha(0.78);
    draw_rectangle_color(0, 0, 960, 270, c1, c1, c2, c2, false);
    draw_rectangle_color(0, 270, 960, 540, c2, c2, c1, c1, false);
    draw_set_alpha(1);
}


// Vagalumes animados (sem precisar de variaveis de instancia)
function ui_vagalumes(_qtd)
{
    var t = current_time / 1000;

    gpu_set_blendmode(bm_add);

    for (var i = 0; i < _qtd; i++)
    {
        var bx = ((i * 137) mod 880) + 40;
        var by = ((i * 89) mod 460) + 40;

        var fx = bx + sin(t * (0.4 + (i mod 5) * 0.08) + i) * 30;
        var fy = by + cos(t * (0.3 + (i mod 4) * 0.07) + i * 1.7) * 22;

        var pulso = 0.35 + 0.35 * sin(t * (1.2 + (i mod 3) * 0.5) + i * 2.1);

        draw_set_alpha(pulso * 0.7);
        draw_circle_color(fx, fy, 9, make_color_rgb(210, 240, 120), c_black, false);

        draw_set_alpha(pulso);
        draw_set_color(make_color_rgb(255, 250, 190));
        draw_circle(fx, fy, 1.7, false);
    }

    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1);
}


// Raios de luz giratorios (tela de recompensa)
function ui_raios(_cx, _cy, _raio, _qtd, _cor)
{
    var rot = current_time / 55;
    var passo = 360 / _qtd;

    gpu_set_blendmode(bm_add);

    draw_primitive_begin(pr_trianglelist);

    for (var i = 0; i < _qtd; i++)
    {
        var a1 = rot + i * passo;
        var a2 = a1 + passo * 0.35;

        draw_vertex_colour(_cx, _cy, _cor, 0.35);
        draw_vertex_colour(_cx + lengthdir_x(_raio, a1), _cy + lengthdir_y(_raio, a1), _cor, 0);
        draw_vertex_colour(_cx + lengthdir_x(_raio, a2), _cy + lengthdir_y(_raio, a2), _cor, 0);
    }

    draw_primitive_end();

    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1);
}


// Entrada suave (fade) ao abrir a sala. Chamar no fim do Draw GUI.
function ui_fade_in()
{
    if (!variable_global_exists("ui_fade_sala") || global.ui_fade_sala != room)
    {
        global.ui_fade_sala = room;
        global.ui_fade_t0 = current_time;
    }

    var a = 1 - clamp((current_time - global.ui_fade_t0) / 400, 0, 1);

    if (a > 0)
    {
        draw_set_alpha(a);
        draw_set_color(c_black);
        draw_rectangle(0, 0, 960, 540, false);
        draw_set_alpha(1);
    }
}


// ==========================================================
// BOTAO
// ==========================================================

// Desenha um botao com hover e efeito de clique.
// _fonte = -1 usa a fonte padrao de botoes.
// Retorna true se o mouse esta sobre o botao.
function ui_botao(_x1, _y1, _x2, _y2, _texto, _cor, _ativo = true, _fonte = -1)
{
    ui_init();

    var fonte = _fonte;
    if (fonte == -1) fonte = global.ui_f_botao;

    var sobre = _ativo && ui_mouse_sobre(_x1, _y1, _x2, _y2);

    if (sobre)
    {
        global.ui_hover_frame = true;
    }

    var press = 0;
    if (sobre && mouse_check_button(mb_left)) press = 2;

    var y1 = _y1 + press;
    var y2 = _y2 + press;

    var cor = _cor;
    var borda = global.ui_cor_ouro;
    var txt = global.ui_cor_creme;

    if (!_ativo)
    {
        cor = make_color_rgb(48, 52, 48);
        borda = make_color_rgb(95, 90, 70);
        txt = make_color_rgb(130, 130, 120);
    }
    else if (sobre)
    {
        cor = merge_color(_cor, c_white, 0.16);
        borda = global.ui_cor_ouro_vivo;
        txt = c_white;
    }

    // sombra
    draw_set_alpha(0.5);
    draw_set_color(global.ui_cor_sombra);
    draw_rectangle(_x1 + 3, _y1 + 5, _x2 + 3, _y2 + 5, false);
    draw_set_alpha(1);

    // corpo
    var topo = merge_color(cor, c_white, 0.14);
    var base = merge_color(cor, c_black, 0.30);

    draw_rectangle_color(_x1, y1, _x2, y2, topo, topo, base, base, false);

    // brilho superior
    draw_set_alpha(0.12);
    draw_set_color(c_white);
    draw_rectangle(_x1 + 2, y1 + 2, _x2 - 2, y1 + (y2 - y1) * 0.45, false);
    draw_set_alpha(1);

    // bordas
    draw_set_color(borda);
    draw_rectangle(_x1, y1, _x2, y2, true);

    draw_set_alpha(0.4);
    draw_rectangle(_x1 + 3, y1 + 3, _x2 - 3, y2 - 3, true);
    draw_set_alpha(1);

    // marcadores de hover
    if (sobre)
    {
        ui_losango(_x1 + 14, (y1 + y2) / 2, 4, borda);
        ui_losango(_x2 - 14, (y1 + y2) / 2, 4, borda);
    }

    ui_texto((_x1 + _x2) / 2, (y1 + y2) / 2, _texto, txt, fonte);

    return sobre;
}


// ==========================================================
// BATALHA: BARRA DE VIDA, PLACA E DANO
// ==========================================================

// Barra de vida com rastro do dano
function ui_barra(_x, _y, _w, _h, _hp, _hp_visual, _hp_max)
{
    ui_init();

    var pct = clamp(_hp / _hp_max, 0, 1);
    var pct_v = clamp(_hp_visual / _hp_max, 0, 1);

    var cor;

    if (pct > 0.5)
    {
        cor = make_color_rgb(80, 200, 90);
    }
    else if (pct > 0.25)
    {
        cor = make_color_rgb(230, 190, 60);
    }
    else
    {
        cor = make_color_rgb(215, 65, 55);
    }

    draw_set_alpha(1);

    // fundo
    draw_set_color(make_color_rgb(10, 14, 12));
    draw_rectangle(_x - 2, _y - 2, _x + _w + 2, _y + _h + 2, false);

    draw_set_color(make_color_rgb(38, 44, 38));
    draw_rectangle(_x, _y, _x + _w, _y + _h, false);

    // rastro do dano
    if (pct_v > pct)
    {
        draw_set_color(make_color_rgb(235, 235, 215));
        draw_rectangle(_x + _w * pct, _y, _x + _w * pct_v, _y + _h, false);
    }

    // vida atual
    if (pct > 0)
    {
        var topo = merge_color(cor, c_white, 0.35);
        var base = merge_color(cor, c_black, 0.25);

        draw_rectangle_color(_x, _y, _x + _w * pct, _y + _h, topo, topo, base, base, false);
    }

    // borda
    draw_set_color(global.ui_cor_ouro);
    draw_rectangle(_x - 2, _y - 2, _x + _w + 2, _y + _h + 2, true);
}


// Placa do combatente: nome + barra + numeros
function ui_hud_combatente(_cx, _y, _nome, _hp, _hp_visual, _hp_max, _larg)
{
    ui_init();

    var pw = _larg + 24;
    var ph = 52;
    var x1 = _cx - pw / 2;
    var y1 = _y;

    draw_set_alpha(0.8);
    draw_set_color(make_color_rgb(10, 20, 15));
    draw_roundrect_ext(x1, y1, x1 + pw, y1 + ph, 8, 8, false);

    draw_set_alpha(1);
    draw_set_color(global.ui_cor_ouro);
    draw_roundrect_ext(x1, y1, x1 + pw, y1 + ph, 8, 8, true);

    ui_texto(_cx, y1 + 13, _nome, global.ui_cor_creme, global.ui_f_texto);

    var bh = 16;
    var by = y1 + 27;

    ui_barra(_cx - _larg / 2, by, _larg, bh, _hp, _hp_visual, _hp_max);

    ui_texto(_cx, by + bh / 2, string(_hp) + " / " + string(_hp_max), c_white, global.ui_f_pequeno);
}


// Numero flutuante generico que sobe e desaparece (dano, cura, etc.)
function ui_numero_flutuante(_x, _y, _texto, _cor, _timer, _timer_max)
{
    ui_init();

    var t = clamp(_timer / _timer_max, 0, 1);
    var subida = (1 - t) * 45;

    draw_set_alpha(min(1, t * 2.5));

    ui_texto(_x, _y - subida, _texto, _cor, global.ui_f_subtitulo);

    draw_set_alpha(1);
}


// Numero de dano que sobe e desaparece
function ui_dano_flutuante(_x, _y, _dano, _timer, _timer_max)
{
    ui_numero_flutuante(_x, _y, "-" + string(_dano), make_color_rgb(255, 95, 70), _timer, _timer_max);
}


// Anel pulsante usado para destacar um alvo selecionável
function ui_anel_alvo(_x, _y, _raio, _cor)
{
    var pulso = 0.5 + 0.5 * sin(current_time / 150);

    draw_set_alpha(pulso);
    draw_set_color(_cor);
    draw_circle(_x, _y, _raio, true);
    draw_set_alpha(pulso * 0.5);
    draw_circle(_x, _y, _raio - 4, true);
    draw_set_alpha(1);
}


// ==========================================================
// CARTOES
// ==========================================================

// Cartao de fase (selecao de fases)
function ui_cartao_fase(_x, _y, _w, _h, _rotulo, _nome, _desc, _liberada, _hover, _sprite = spr_fundo_floresta)
{
    ui_init();

    var cor = make_color_rgb(42, 44, 42);
    var borda = make_color_rgb(110, 100, 75);

    if (_liberada)
    {
        cor = make_color_rgb(44, 84, 58);
        borda = _hover ? global.ui_cor_ouro_vivo : global.ui_cor_ouro;
    }

    // brilho externo no hover
    if (_hover && _liberada)
    {
        draw_set_alpha(0.5);
        draw_set_color(borda);
        draw_rectangle(_x - 3, _y - 3, _x + _w + 3, _y + _h + 3, true);
        draw_set_alpha(1);
    }

    ui_painel(_x, _y, _x + _w, _y + _h, cor, borda, 1);

    // miniatura da floresta
    var mx = _x + 12;
    var my = _y + 12;
    var mw = _w - 24;
    var mh = 96;
    var esc = mw / 720;

    var col = _liberada ? c_white : make_color_rgb(70, 70, 70);

    draw_sprite_part_ext(_sprite, 0, 120, 200, 720, mh / esc, mx, my, esc, esc, col, 1);

    draw_set_color(borda);
    draw_rectangle(mx, my, mx + mw, my + mh, true);

    if (!_liberada)
    {
        ui_cadeado(_x + _w / 2, my + mh / 2 - 8, global.ui_cor_ouro);
    }

    var cx = _x + _w / 2;

    var cor_rotulo = _liberada ? global.ui_cor_ouro : make_color_rgb(150, 135, 95);
    var cor_nome = _liberada ? global.ui_cor_creme : make_color_rgb(160, 160, 155);
    var cor_desc = _liberada ? make_color_rgb(200, 215, 185) : make_color_rgb(150, 150, 145);

    ui_texto(cx, _y + 130, _rotulo, cor_rotulo, global.ui_f_texto);
    ui_texto(cx, _y + 160, _nome, cor_nome, global.ui_f_subtitulo);
    ui_texto(cx, _y + 200, _desc, cor_desc, global.ui_f_pequeno);
}


// Cartao de personagem da enciclopedia (pergaminho)
function ui_cartao_lenda(_x, _y, _w, _h, _sprite, _nome, _funcao, _hover, _escala = 1)
{
    ui_init();

    var lift = _hover ? 4 : 0;
    var y1 = _y - lift;
    var y2 = _y + _h - lift;

    var borda = _hover ? global.ui_cor_ouro_vivo : make_color_rgb(120, 90, 50);

    ui_painel(_x, y1, _x + _w, y2, global.ui_cor_pergaminho, borda, 1);

    var cx = _x + _w / 2;
    var cy = y1 + _h * 0.42;

    // aura atras do personagem
    draw_circle_color(cx, cy, min(_w, _h) * 0.36, make_color_rgb(244, 234, 200), global.ui_cor_pergaminho, false);

    draw_sprite_ext(_sprite, current_time / 160, cx, cy, _escala, _escala, 0, c_white, 1);

    ui_texto_liso(cx, y2 - 56, _nome, global.ui_cor_tinta, global.ui_f_botao);

    if (_funcao != "")
    {
        ui_etiqueta(cx, y2 - 26, _funcao, ui_cor_funcao(_funcao), global.ui_cor_creme, global.ui_f_pequeno);
    }
}


// ==========================================================
// NOVAS FUNÇÕES (fases 3 a 6)
// ==========================================================

// Placa compacta (usada quando há 3 ou mais combatentes no lado)
function ui_hud_compacto(_cx, _y, _nome, _hp, _hp_visual, _hp_max, _larg)
{
    ui_init();

    var pw = _larg + 16;
    var ph = 36;
    var x1 = _cx - pw / 2;
    var y1 = _y;

    draw_set_alpha(0.8);
    draw_set_color(make_color_rgb(10, 20, 15));
    draw_roundrect_ext(x1, y1, x1 + pw, y1 + ph, 7, 7, false);

    draw_set_alpha(1);
    draw_set_color(global.ui_cor_ouro);
    draw_roundrect_ext(x1, y1, x1 + pw, y1 + ph, 7, 7, true);

    ui_texto(_cx, y1 + 10, _nome, global.ui_cor_creme, global.ui_f_pequeno);

    var bh = 12;
    var by = y1 + 19;

    ui_barra(_cx - _larg / 2, by, _larg, bh, _hp, _hp_visual, _hp_max);

    ui_texto(_cx, by + bh / 2, string(_hp) + " / " + string(_hp_max), c_white, global.ui_f_pequeno);
}


// Etiquetas de status embaixo da placa (fogo, veneno, escudo...)
function ui_status(_cx, _y, _c)
{
    if (_c.hp <= 0)
    {
        return;
    }

    var _txt = [];
    var _cor = [];

    if (_c.atordoado > 0)
    {
        array_push(_txt, "ATORDOADO");
        array_push(_cor, make_color_rgb(150, 125, 30));
    }

    if (_c.confuso > 0)
    {
        array_push(_txt, "CONFUSO " + string(_c.confuso));
        array_push(_cor, make_color_rgb(105, 60, 135));
    }

    if (_c.dot_turnos > 0)
    {
        if (_c.dot_tipo == "veneno")
        {
            array_push(_txt, "VENENO " + string(_c.dot_turnos));
            array_push(_cor, make_color_rgb(70, 120, 40));
        }
        else
        {
            array_push(_txt, "FOGO " + string(_c.dot_turnos));
            array_push(_cor, make_color_rgb(175, 75, 30));
        }
    }

    if (_c.escudo_turnos > 0)
    {
        array_push(_txt, "ESCUDO " + string(_c.escudo_turnos));
        array_push(_cor, make_color_rgb(45, 95, 150));
    }

    if (_c.furia)
    {
        array_push(_txt, "FÚRIA");
        array_push(_cor, make_color_rgb(160, 35, 35));
    }

    var _n = array_length(_txt);

    if (_n == 0)
    {
        return;
    }

    draw_set_font(global.ui_f_pequeno);

    var _larguras = [];
    var _total = 0;

    for (var i = 0; i < _n; i++)
    {
        var _w = string_width(_txt[i]) + 22;

        array_push(_larguras, _w);
        _total += _w + 4;
    }

    var _px = _cx - (_total - 4) / 2;

    for (var i = 0; i < _n; i++)
    {
        ui_etiqueta(_px + _larguras[i] / 2, _y, _txt[i], _cor[i], c_white, global.ui_f_pequeno);
        _px += _larguras[i] + 4;
    }
}


// Cartão de fase compacto (6 fases na tela)
function ui_cartao_fase_compacto(_x, _y, _w, _h, _rotulo, _nome, _desc, _extra, _liberada, _hover, _sprite, _final)
{
    ui_init();

    var cor = make_color_rgb(42, 44, 42);
    var borda = make_color_rgb(110, 100, 75);

    if (_liberada)
    {
        cor = _final ? make_color_rgb(88, 34, 30) : make_color_rgb(44, 84, 58);
        borda = _hover ? global.ui_cor_ouro_vivo : global.ui_cor_ouro;
    }

    if (_hover && _liberada)
    {
        draw_set_alpha(0.5);
        draw_set_color(borda);
        draw_rectangle(_x - 3, _y - 3, _x + _w + 3, _y + _h + 3, true);
        draw_set_alpha(1);
    }

    ui_painel(_x, _y, _x + _w, _y + _h, cor, borda, 1);

    // miniatura do cenário
    var mx = _x + 10;
    var my = _y + 10;
    var mw = _w - 20;
    var mh = 54;
    var esc = mw / 720;

    var col = _liberada ? c_white : make_color_rgb(70, 70, 70);

    draw_sprite_part_ext(_sprite, 0, 120, 230, 720, mh / esc, mx, my, esc, esc, col, 1);

    draw_set_color(borda);
    draw_rectangle(mx, my, mx + mw, my + mh, true);

    if (!_liberada)
    {
        ui_cadeado(_x + _w / 2, my + mh / 2 - 8, global.ui_cor_ouro);
    }

    var cx = _x + _w / 2;

    var cor_rotulo = _liberada ? global.ui_cor_ouro : make_color_rgb(150, 135, 95);
    var cor_nome = _liberada ? global.ui_cor_creme : make_color_rgb(160, 160, 155);
    var cor_desc = _liberada ? make_color_rgb(200, 215, 185) : make_color_rgb(150, 150, 145);

    ui_texto(cx, _y + 78, _rotulo, cor_rotulo, global.ui_f_pequeno);
    ui_texto(cx, _y + 97, _nome, cor_nome, global.ui_f_botao);
    ui_texto(cx, _y + 117, _desc, cor_desc, global.ui_f_pequeno);

    if (_extra != "")
    {
        ui_texto(cx, _y + 136, _extra, make_color_rgb(235, 205, 120), global.ui_f_pequeno);
    }
}


// Partículas de clima (desenhadas atrás dos combatentes)
function ui_particulas(_tipo, _qtd)
{
    if (_tipo == "vagalumes")
    {
        ui_vagalumes(_qtd);
        return;
    }

    var t = current_time / 1000;

    if (_tipo == "brasas")
    {
        gpu_set_blendmode(bm_add);

        for (var i = 0; i < _qtd; i++)
        {
            var vel = 18 + (i mod 7) * 6;
            var bx = ((i * 151) mod 940) + 10;
            var by = 540 - ((t * vel + i * 97) mod 560);
            var fx = bx + sin(t * 1.3 + i) * 14;

            draw_set_alpha(0.55 + 0.35 * sin(t * 3 + i));
            draw_set_color((i mod 3 == 0) ? make_color_rgb(255, 210, 120) : make_color_rgb(255, 120, 40));
            draw_circle(fx, by, 1.6, false);
        }

        gpu_set_blendmode(bm_normal);
    }
    else if (_tipo == "cinzas")
    {
        for (var i = 0; i < _qtd; i++)
        {
            var vel = 10 + (i mod 5) * 5;
            var bx = ((i * 173) mod 940) + 10;
            var by = ((t * vel + i * 71) mod 560) - 10;
            var fx = bx + sin(t * 0.9 + i * 1.3) * 20;

            draw_set_alpha(0.5);
            draw_set_color((i mod 4 == 0) ? make_color_rgb(255, 120, 50) : make_color_rgb(110, 105, 105));
            draw_rectangle(fx, by, fx + 2, by + 2, false);
        }
    }
    else if (_tipo == "veneno")
    {
        for (var i = 0; i < _qtd; i++)
        {
            var bx = ((i * 137) mod 900) + 30;
            var by = ((i * 89) mod 360) + 90;
            var fx = bx + sin(t * (0.3 + (i mod 4) * 0.07) + i) * 26;
            var fy = by + cos(t * (0.25 + (i mod 3) * 0.06) + i * 1.7) * 18;

            draw_set_alpha(0.12 + 0.08 * sin(t + i));
            draw_set_color(make_color_rgb(150, 200, 60));
            draw_circle(fx, fy, 10 + (i mod 4) * 4, false);
        }
    }

    draw_set_alpha(1);
}
