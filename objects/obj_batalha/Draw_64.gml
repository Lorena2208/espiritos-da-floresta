// ==========================================
// INTERFACE DA BATALHA
// ==========================================

ui_begin();

if (array_length(herois) == 0)
{
    ui_fim();
    exit;
}


// ==========================================
// FAIXA SUPERIOR
// ==========================================

draw_set_alpha(0.75);
draw_set_color(make_color_rgb(10, 20, 15));
draw_roundrect_ext(300, 12, 660, 44, 10, 10, false);

draw_set_alpha(1);
draw_set_color(global.ui_cor_ouro);
draw_roundrect_ext(300, 12, 660, 44, 10, 10, true);

ui_texto(480, 28, fase.rotulo + " · Onda " + string(onda_atual + 1) + " de " + string(array_length(ondas)), global.ui_cor_creme, global.ui_f_texto);


// ==========================================
// PLACAS DE VIDA, STATUS E NÚMEROS
// ==========================================

var _vez = (estado == "jogador_ataque" || estado == "jogador_alvo");

for (var i = 0; i < array_length(herois); i++)
{
    bt_desenhar_hud(herois[i], _vez && i == heroi_indice);
}

for (var i = 0; i < array_length(inimigos); i++)
{
    bt_desenhar_hud(inimigos[i], estado == "turno_inimigos" && i == inimigo_indice - 1 && timer < 30);
}


// ==========================================
// DESTAQUE DOS ALVOS SELECIONÁVEIS
// ==========================================

if (estado == "jogador_alvo")
{
    var _lista = (acao_alvo_cat == "inimigo") ? inimigos : herois;

    for (var i = 0; i < array_length(_lista); i++)
    {
        var _t = _lista[i];

        if (instance_exists(_t) && _t.hp > 0)
        {
            var _ax = (_t.bbox_left + _t.bbox_right) / 2;
            var _ay = (_t.bbox_top + _t.bbox_bottom) / 2;
            var _ar = clamp(max(_t.bbox_right - _t.bbox_left, _t.bbox_bottom - _t.bbox_top) * 0.5, 44, 110);

            ui_anel_alvo(_ax, _ay, _ar, global.ui_cor_ouro_vivo);
        }
    }
}


// ==========================================
// PAINEL INFERIOR
// ==========================================

ui_painel(40, 396, 920, 506, make_color_rgb(20, 38, 28), global.ui_cor_ouro, 0.94);


// ==========================================
// INDICADOR DE TURNO + MENSAGEM
// ==========================================

var tag = "";
var tag_cor = make_color_rgb(40, 120, 65);

switch (estado)
{
    case "jogador_ataque":
    case "jogador_alvo":
    case "verificar_acao":
    case "heroi_atordoado":
        tag = "SEU TURNO";
        tag_cor = make_color_rgb(40, 120, 65);
        break;

    case "turno_inimigos":
        tag = "TURNO INIMIGO";
        tag_cor = make_color_rgb(150, 55, 45);
        break;

    case "fim_rodada":
        tag = "FIM DA RODADA";
        tag_cor = make_color_rgb(110, 80, 50);
        break;

    case "transicao_onda":
    case "entrada_onda":
        tag = "NOVA ONDA";
        tag_cor = make_color_rgb(150, 120, 45);
        break;

    case "vitoria":
        tag = "VITÓRIA";
        tag_cor = make_color_rgb(170, 140, 50);
        break;

    case "derrota":
        tag = "DERROTA";
        tag_cor = make_color_rgb(110, 40, 40);
        break;
}

if (tag != "")
{
    ui_etiqueta(140, 418, tag, tag_cor, c_white, global.ui_f_pequeno);
}

ui_texto_esq(240, 418, mensagem, global.ui_cor_creme, global.ui_f_subtitulo);

draw_set_alpha(0.3);
draw_set_color(global.ui_cor_ouro);
draw_line(60, 435, 900, 435);
draw_set_alpha(1);


// ==========================================
// BOTÕES
// ==========================================

if (estado == "jogador_alvo")
{
    // ------------------------------------------
    // BOTÃO CANCELAR (ocupa o espaço dos 2 ataques)
    // ------------------------------------------

    ui_botao(
        botao1_x,
        botao_y,
        botao2_x + botao_largura,
        botao_y + botao_altura,
        "CANCELAR",
        make_color_rgb(90, 60, 55)
    );
}
else
{
    var ativo = (estado == "jogador_ataque" && !global.pausado);

    var txt_nome = ativo ? c_white : make_color_rgb(130, 130, 120);

    for (var k = 1; k <= 2; k++)
    {
        var _ac = bt_ler_acao(heroi_atual, k);
        var _bx = (k == 1) ? botao1_x : botao2_x;
        var _apoio = (_ac.tipo == "cura" || _ac.tipo == "escudo");

        var _cor_btn = (k == 1) ? make_color_rgb(70, 100, 150) : make_color_rgb(130, 70, 70);

        if (_ac.tipo == "cura")
        {
            _cor_btn = make_color_rgb(55, 110, 90);
        }
        else if (_ac.tipo == "escudo")
        {
            _cor_btn = make_color_rgb(45, 90, 130);
        }

        ui_botao(_bx, botao_y, _bx + botao_largura, botao_y + botao_altura, "", _cor_btn, ativo);

        var _cor_valor = make_color_rgb(110, 110, 100);

        if (ativo)
        {
            _cor_valor = _apoio ? make_color_rgb(150, 235, 165) : make_color_rgb(255, 205, 120);
        }

        ui_texto(_bx + botao_largura / 2, botao_y + 19, string(k) + ". " + _ac.nome, txt_nome, global.ui_f_botao);
        ui_texto(_bx + botao_largura / 2, botao_y + 40, bt_descricao_ataque(_ac.tipo, _ac.valor, _ac.alvo, _ac.efeito, _ac.chance), _cor_valor, global.ui_f_pequeno);
    }
}


// ==========================================
// BOTÃO DE PAUSA
// ==========================================

ui_botao(
    pausa_btn_x1,
    pausa_btn_y1,
    pausa_btn_x2,
    pausa_btn_y2,
    "II",
    make_color_rgb(60, 70, 55),
    (estado != "vitoria" && estado != "derrota" && !global.pausado)
);

ui_texto(pausa_btn_x1 + (pausa_btn_x2 - pausa_btn_x1) / 2, pausa_btn_y2 + 10, "ESC", make_color_rgb(150, 160, 130), global.ui_f_pequeno);


// ==========================================
// TELA DE PAUSA
// ==========================================

if (global.pausado)
{
    // Escurece a batalha

    draw_set_alpha(0.68);
    draw_set_color(make_color_rgb(4, 10, 7));
    draw_rectangle(0, 0, 960, 540, false);
    draw_set_alpha(1);

    ui_painel(290, 100, 670, 440, make_color_rgb(22, 42, 30), global.ui_cor_ouro, 0.97);


    if (pausa_confirmar == "")
    {
        // ------------------------------
        // MENU DE PAUSA
        // ------------------------------

        ui_texto(480, 148, "PAUSADO", global.ui_cor_ouro, global.ui_f_titulo);
        ui_divisor(480, 184, 300);

        ui_botao(
            pausa_btn_x, pausa_continuar_y,
            pausa_btn_x + pausa_btn_largura, pausa_continuar_y + pausa_btn_altura,
            "CONTINUAR",
            make_color_rgb(49, 92, 64)
        );

        ui_botao(
            pausa_btn_x, pausa_reiniciar_y,
            pausa_btn_x + pausa_btn_largura, pausa_reiniciar_y + pausa_btn_altura,
            "REINICIAR BATALHA",
            make_color_rgb(91, 69, 42)
        );

        ui_botao(
            pausa_btn_x, pausa_menu_y,
            pausa_btn_x + pausa_btn_largura, pausa_menu_y + pausa_btn_altura,
            "SAIR PARA O MENU",
            make_color_rgb(80, 45, 40)
        );

        ui_texto(480, 418, "ESC ou P para continuar", make_color_rgb(150, 160, 130), global.ui_f_pequeno);
    }
    else
    {
        // ------------------------------
        // CONFIRMAÇÃO
        // ------------------------------

        var _titulo = (pausa_confirmar == "menu") ? "SAIR PARA O MENU?" : "REINICIAR BATALHA?";

        ui_texto(480, 148, _titulo, global.ui_cor_ouro, global.ui_f_subtitulo);
        ui_divisor(480, 184, 300);

        ui_texto(480, 240, "O progresso desta batalha", global.ui_cor_creme, global.ui_f_texto);
        ui_texto(480, 266, "será perdido.", global.ui_cor_creme, global.ui_f_texto);

        ui_botao(
            pausa_sim_x, pausa_conf_y,
            pausa_sim_x + pausa_conf_largura, pausa_conf_y + pausa_conf_altura,
            "SIM",
            make_color_rgb(130, 70, 70)
        );

        ui_botao(
            pausa_nao_x, pausa_conf_y,
            pausa_nao_x + pausa_conf_largura, pausa_conf_y + pausa_conf_altura,
            "NÃO",
            make_color_rgb(49, 92, 64)
        );

        ui_texto(480, 418, "ESC para voltar", make_color_rgb(150, 160, 130), global.ui_f_pequeno);
    }
}

ui_fim();
