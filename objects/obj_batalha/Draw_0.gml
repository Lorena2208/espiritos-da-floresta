// ==========================================
// CLIMA DA FASE (partículas atrás dos combatentes)
// ==========================================

if (variable_struct_exists(fase, "clima"))
{
    ui_init();

    ui_particulas(fase.clima, 26);

    ui_reset();
}
