// ==========================================
// FORMAÇÃO DE EQUIPE
// ==========================================

ui_begin();

ui_fundo();
ui_vagalumes(14);
ui_moldura();


// ==========================================
// TÍTULO
// ==========================================

var _f = fase_dados(global.fase_atual);

ui_texto(480, 50, "FORMAÇÃO DE EQUIPE", global.ui_cor_ouro, global.ui_f_titulo);
ui_texto(480, 82, _f.rotulo + " · " + _f.nome + " - escolha até " + string(vagas) + " lendas", make_color_rgb(200, 200, 180), global.ui_f_texto);


// ==========================================
// ÁREA DA EQUIPE
// ==========================================

ui_painel(70, 102, 890, 294, make_color_rgb(34, 50, 38), global.ui_cor_ouro, 0.95);

ui_texto(480, 118, "SUA EQUIPE", global.ui_cor_ouro, global.ui_f_botao);


// ==========================================
// SLOTS
// ==========================================

for (var i = 0; i < vagas; i++)
{
    var sx = slots_x[i];
    var cx = sx + card_largura / 2;

    var ocupado = (slots[i] != -1);

    var sobre_slot = ui_mouse_sobre(sx, equipe_y, sx + card_largura, equipe_y + card_altura);

    var borda_slot = make_color_rgb(150, 145, 115);

    if (ocupado && sobre_slot)
    {
        borda_slot = global.ui_cor_ouro_vivo;
        global.ui_hover_frame = true;
    }
    else if (ocupado)
    {
        borda_slot = global.ui_cor_ouro;
    }

    ui_painel(sx, equipe_y, sx + card_largura, equipe_y + card_altura, make_color_rgb(30, 40, 32), borda_slot);

    // número do slot
    draw_set_color(make_color_rgb(70, 58, 30));
    draw_circle(sx + 17, equipe_y + 17, 11, false);
    draw_set_color(global.ui_cor_ouro);
    draw_circle(sx + 17, equipe_y + 17, 11, true);
    ui_texto_liso(sx + 17, equipe_y + 17, string(i + 1), global.ui_cor_creme, global.ui_f_pequeno);

    if (ocupado)
    {
        var ps = global.personagens[slots[i]];

        draw_circle_color(cx, equipe_y + 66, 44, make_color_rgb(70, 95, 70), make_color_rgb(30, 40, 32), false);

        draw_sprite_ext(ps.sprite, current_time / 160, cx, equipe_y + 66, 0.65, 0.65, 0, c_white, 1);

        ui_texto(cx, equipe_y + 122, ps.nome, c_white, global.ui_f_texto);

        ui_etiqueta(cx, equipe_y + 140, ps.funcao, ui_cor_funcao(ps.funcao), global.ui_cor_creme, global.ui_f_pequeno);
    }
    else
    {
        ui_texto(cx, equipe_y + 68, "+", make_color_rgb(95, 100, 85), global.ui_f_titulo);
        ui_texto(cx, equipe_y + 110, "VAZIO", make_color_rgb(120, 120, 110), global.ui_f_pequeno);
    }
}


// ==========================================
// PERSONAGENS DISPONÍVEIS
// ==========================================

ui_texto(480, 312, "LENDAS DO FOLCLORE", global.ui_cor_ouro, global.ui_f_botao);

for (var i = 0; i < n_personagens; i++)
{
    var px = personagens_x[i];
    var pcx = px + personagem_largura / 2;

    var p = global.personagens[i];

    var esta = na_equipe(i);

    var sobre_card = ui_mouse_sobre(px, personagem_y, px + personagem_largura, personagem_y + personagem_altura);

    if (p.desbloqueado)
    {
        var cor_card = make_color_rgb(55, 65, 55);
        var borda_card = make_color_rgb(150, 145, 115);

        if (esta)
        {
            cor_card = make_color_rgb(44, 88, 58);
            borda_card = global.ui_cor_ouro;
        }

        if (sobre_card)
        {
            borda_card = global.ui_cor_ouro_vivo;
            global.ui_hover_frame = true;
        }

        ui_painel(px, personagem_y, px + personagem_largura, personagem_y + personagem_altura, cor_card, borda_card);

        draw_sprite_ext(p.sprite, current_time / 160, pcx, personagem_y + 44, 0.42, 0.42, 0, c_white, 1);

        ui_texto(pcx, personagem_y + 84, p.nome, c_white, global.ui_f_texto);

        ui_etiqueta(pcx, personagem_y + 103, p.funcao, ui_cor_funcao(p.funcao), global.ui_cor_creme, global.ui_f_pequeno);

        if (esta)
        {
            ui_etiqueta(pcx, personagem_y + 12, "NA EQUIPE", make_color_rgb(40, 120, 65), c_white, global.ui_f_pequeno);
        }
    }
    else
    {
        ui_painel(px, personagem_y, px + personagem_largura, personagem_y + personagem_altura, make_color_rgb(38, 42, 38), make_color_rgb(95, 90, 70));

        // silhueta misteriosa
        draw_sprite_ext(p.sprite, 0, pcx, personagem_y + 44, 0.42, 0.42, 0, c_black, 0.55);

        ui_cadeado(pcx, personagem_y + 34, make_color_rgb(150, 135, 95));

        ui_texto(pcx, personagem_y + 90, "BLOQUEADO", make_color_rgb(130, 130, 120), global.ui_f_texto);
    }
}


// ==========================================
// BOTÕES
// ==========================================

var pode_comecar = equipe_ok();

ui_botao(
    botao_voltar_x,
    botao_voltar_y,
    botao_voltar_x + botao_voltar_largura,
    botao_voltar_y + botao_voltar_altura,
    "< VOLTAR",
    make_color_rgb(70, 70, 50)
);

ui_botao(
    botao_comecar_x,
    botao_comecar_y,
    botao_comecar_x + botao_comecar_largura,
    botao_comecar_y + botao_comecar_altura,
    "COMEÇAR",
    make_color_rgb(45, 120, 65),
    pode_comecar
);

ui_texto(
    480,
    484,
    pode_comecar ? "Clique numa lenda para adicionar ou remover" : "Escolha pelo menos um personagem",
    make_color_rgb(170, 175, 150),
    global.ui_f_pequeno
);

ui_fade_in();
ui_fim();
