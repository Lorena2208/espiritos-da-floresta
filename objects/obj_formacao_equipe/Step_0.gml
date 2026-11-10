// ==========================================
// CLIQUE
// ==========================================

if (mouse_check_button_pressed(mb_left))
{
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);


    // ==========================================
    // CARDS DOS PERSONAGENS: ADICIONAR / REMOVER
    // ==========================================

    for (var i = 0; i < n_personagens; i++)
    {
        if (
            mx >= personagens_x[i] &&
            mx <= personagens_x[i] + personagem_largura &&
            my >= personagem_y &&
            my <= personagem_y + personagem_altura &&
            global.personagens[i].desbloqueado
        )
        {
            var encontrado = false;

            // se já está na equipe, sai
            for (var s = 0; s < vagas; s++)
            {
                if (slots[s] == i)
                {
                    slots[s] = -1;
                    encontrado = true;
                }
            }

            // se não estava, entra no primeiro slot vazio
            if (!encontrado)
            {
                for (var s = 0; s < vagas; s++)
                {
                    if (slots[s] == -1)
                    {
                        slots[s] = i;
                        break;
                    }
                }
            }
        }
    }


    // ==========================================
    // CLICAR NOS SLOTS PARA REMOVER
    // ==========================================

    for (var s = 0; s < vagas; s++)
    {
        if (
            mx >= slots_x[s] &&
            mx <= slots_x[s] + card_largura &&
            my >= equipe_y &&
            my <= equipe_y + card_altura
        )
        {
            slots[s] = -1;
        }
    }


    // ==========================================
    // COMEÇAR
    // ==========================================

    if (
        mx >= botao_comecar_x &&
        mx <= botao_comecar_x + botao_comecar_largura &&
        my >= botao_comecar_y &&
        my <= botao_comecar_y + botao_comecar_altura
    )
    {
        // Pelo menos um personagem precisa estar escolhido.

        if (equipe_ok())
        {
            // Salvar equipe globalmente (sempre 4 posições)
            global.equipe = [-1, -1, -1, -1];

            for (var s = 0; s < vagas; s++)
            {
                global.equipe[s] = slots[s];
            }

            room_goto(fase_dados(global.fase_atual).sala);
        }
    }


    // ==========================================
    // VOLTAR PARA A SELEÇÃO DE FASES
    // ==========================================

    if (
        mx >= botao_voltar_x &&
        mx <= botao_voltar_x + botao_voltar_largura &&
        my >= botao_voltar_y &&
        my <= botao_voltar_y + botao_voltar_altura
    )
    {
        room_goto(rm_selecao_fases);
    }
}
