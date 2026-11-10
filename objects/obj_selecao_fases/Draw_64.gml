// ==========================================
// SELEÇÃO DE FASES
// ==========================================

ui_begin();

ui_fundo();
ui_vagalumes(18);
ui_moldura();


// ==========================================
// TÍTULO
// ==========================================

ui_titulo(62, "SELECIONE UMA FASE");
ui_divisor(480, 98, 440);


// ==========================================
// CARTÕES
// ==========================================

var _total = fases_total();

for (var i = 0; i < _total; i++)
{
    var _f = fase_dados(i + 1);
    var _x = cards_x[i];
    var _y = cards_y[i];

    var _liberada = (i + 1 <= global.fase_desbloqueada);
    var _sobre = ui_mouse_sobre(_x, _y, _x + largura, _y + altura);

    if (_sobre && _liberada)
    {
        global.ui_hover_frame = true;
    }

    var _desc = _liberada ? _f.desc : "Complete a fase " + string(i);
    var _extra = "";

    if (_liberada)
    {
        if (_f.recompensa >= 0)
        {
            var _p = global.personagens[_f.recompensa];

            _extra = _p.desbloqueado ? ("Lenda resgatada: " + _p.nome) : "Resgate uma nova lenda!";
        }
        else
        {
            _extra = "Chefão final";
        }
    }

    ui_cartao_fase_compacto(_x, _y, largura, altura, _f.rotulo, _f.nome, _desc, _extra, _liberada, _sobre, _f.fundo, _f.recompensa < 0);
}


// ==========================================
// BOTÃO VOLTAR
// ==========================================

ui_botao(
    botao_voltar_x,
    botao_voltar_y,
    botao_voltar_x + botao_voltar_largura,
    botao_voltar_y + botao_voltar_altura,
    "VOLTAR",
    make_color_rgb(70, 70, 50)
);

ui_fade_in();
ui_fim();
