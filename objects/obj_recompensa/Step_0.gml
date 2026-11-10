// ==========================================
// CLIQUE
// ==========================================

if (mouse_check_button_pressed(mb_left))
{
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);


    // ==========================================
    // CONTINUAR
    // ==========================================

    if (
        mx >= botao_x &&
        mx <= botao_x + botao_largura &&
        my >= botao_y &&
        my <= botao_y + botao_altura
    )
    {
        // A recompensa já foi recebida.
        // Limpa a recompensa pendente.

        global.personagem_recompensa = -1;


        // Voltar para seleção de fases

        room_goto(rm_selecao_fases);
    }
}