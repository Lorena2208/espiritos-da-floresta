// ==========================================
// ENCICLOPÉDIA
// ==========================================

ui_begin();

ui_fundo();
ui_vagalumes(16);
ui_moldura();


// ==========================================
// PÁGINA DO PERSONAGEM
// ==========================================

if (personagem_selecionado != -1)
{
    var p = global.personagens[personagem_selecionado];


    // ======================================
    // BOTÃO VOLTAR (mesma área do Step)
    // ======================================

    ui_botao(
        voltar_pg_x1,
        voltar_pg_y1,
        voltar_pg_x2,
        voltar_pg_y2,
        "< VOLTAR",
        make_color_rgb(65, 75, 55)
    );


    // ======================================
    // TÍTULO
    // ======================================

    ui_texto(480, 68, p.nome, global.ui_cor_ouro, global.ui_f_titulo);
    ui_divisor(480, 106, 300);


    // ======================================
    // RETRATO
    // ======================================

    ui_painel(70, 125, 390, 490, global.ui_cor_pergaminho, make_color_rgb(120, 90, 50));

    draw_circle_color(230, 285, 125, make_color_rgb(244, 234, 200), global.ui_cor_pergaminho, false);

    draw_sprite_ext(p.retrato, current_time / 160, 230, 290, 1.5, 1.5, 0, c_white, 1);

    ui_etiqueta(230, 450, p.funcao, ui_cor_funcao(p.funcao), global.ui_cor_creme, global.ui_f_texto);

    ui_texto(230, 474, p.ataques, global.ui_cor_tinta, global.ui_f_pequeno);


    // ======================================
    // INFORMAÇÕES
    // ======================================

    ui_painel(420, 125, 905, 490, make_color_rgb(22, 40, 30), global.ui_cor_ouro, 0.95);

    var tx = 445;
    var tl = 435;

    // ORIGEM
    ui_texto_esq(tx, 148, "ORIGEM", global.ui_cor_ouro, global.ui_f_botao);
    ui_paragrafo(tx, 170, string_replace_all(p.origem, "\n", " "), global.ui_cor_creme, global.ui_f_texto, tl, 21);

    ui_divisor(662, 246, 400);

    // REGIÕES
    ui_texto_esq(tx, 268, "REGIÕES", global.ui_cor_ouro, global.ui_f_botao);
    ui_paragrafo(tx, 290, string_replace_all(p.regioes, "\n", " "), global.ui_cor_creme, global.ui_f_texto, tl, 21);

    ui_divisor(662, 368, 400);

    // A LENDA
    ui_texto_esq(tx, 390, "A LENDA", global.ui_cor_ouro, global.ui_f_botao);
    ui_paragrafo(tx, 412, string_replace_all(p.historia, "\n", " "), global.ui_cor_creme, global.ui_f_texto, tl, 21);
}


// ==========================================
// TELA PRINCIPAL DA ENCICLOPÉDIA
// ==========================================

else
{
    ui_texto(480, 62, "ENCICLOPÉDIA", global.ui_cor_ouro, global.ui_f_titulo);
    ui_divisor(480, 98, 380);
    ui_texto(480, 118, "Criaturas e lendas do Brasil", global.ui_cor_creme, global.ui_f_texto);


    // ======================================
    // CARDS DOS PERSONAGENS
    // ======================================

    var _n = min(array_length(global.personagens), array_length(cards_x));

    for (var i = 0; i < _n; i++)
    {
        var _p = global.personagens[i];
        var xx = cards_x[i];
        var yy = cards_y[i];

        var sobre = ui_mouse_sobre(xx, yy, xx + card_largura, yy + card_altura);

        if (sobre)
        {
            global.ui_hover_frame = true;
        }

        ui_cartao_lenda(xx, yy, card_largura, card_altura, _p.sprite, _p.nome, _p.funcao, sobre, 0.72);
    }


    // ======================================
    // BOTÃO VOLTAR AO MENU
    // ======================================

    ui_botao(
        botao_voltar_x,
        botao_voltar_y,
        botao_voltar_x + botao_voltar_largura,
        botao_voltar_y + botao_voltar_altura,
        "VOLTAR AO MENU",
        make_color_rgb(65, 75, 55)
    );
}

ui_fade_in();
ui_fim();
