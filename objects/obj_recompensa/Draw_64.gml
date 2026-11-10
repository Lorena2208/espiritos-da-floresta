// ==========================================
// TELA DE RECOMPENSA
// ==========================================

ui_begin();

ui_fundo(true, make_color_rgb(8, 20, 28), make_color_rgb(20, 48, 60));

// Raios de luz atrás do personagem
ui_raios(480, 270, 235, 14, global.ui_cor_ouro);

ui_vagalumes(28);
ui_moldura();


if (
    global.personagem_recompensa >= 0 &&
    global.personagem_recompensa < array_length(global.personagens)
)
{
    var p = global.personagens[global.personagem_recompensa];

    // ======================================
    // TÍTULO
    // ======================================

    ui_titulo(68, "NOVO PERSONAGEM!");

    var _sub = "Você desbloqueou uma nova lenda!";

    if (lendas_desbloqueadas() == 4)
    {
        _sub = "Nova lenda! Agora sua equipe tem 4 vagas!";
    }

    ui_texto(480, 112, _sub, global.ui_cor_creme, global.ui_f_texto);


    // ======================================
    // CARTÃO DO PERSONAGEM
    // ======================================

    ui_painel(300, 140, 660, 400, make_color_rgb(26, 58, 70), global.ui_cor_ouro, 0.96);

    draw_circle_color(480, 250, 105, make_color_rgb(80, 130, 140), make_color_rgb(26, 58, 70), false);

    draw_sprite_ext(p.retrato, current_time / 160, 480, 250, 1.4, 1.4, 0, c_white, 1);

    ui_texto(480, 352, p.nome, global.ui_cor_ouro, global.ui_f_subtitulo);

    ui_etiqueta(480, 380, p.funcao, ui_cor_funcao(p.funcao), global.ui_cor_creme, global.ui_f_pequeno);

    ui_texto(480, 418, "Ataques: " + p.ataques, make_color_rgb(200, 215, 185), global.ui_f_pequeno);
}


// ==========================================
// BOTÃO CONTINUAR
// ==========================================

ui_botao(
    botao_x,
    botao_y,
    botao_x + botao_largura,
    botao_y + botao_altura,
    "CONTINUAR",
    make_color_rgb(45, 110, 130)
);

ui_fade_in();
ui_fim();
