// ==========================================
// BOTÃO CONTINUAR
// ==========================================

botao_x = 330;
botao_y = 440;

botao_largura = 300;
botao_altura = 55;


// ==========================================
// GARANTIR QUE EXISTE UMA RECOMPENSA
// ==========================================

if (!variable_global_exists("personagem_recompensa"))
{
    global.personagem_recompensa = -1;
}