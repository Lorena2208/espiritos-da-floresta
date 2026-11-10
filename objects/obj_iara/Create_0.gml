// IARA - SUPORTE / CURA
event_inherited();

nome = "Iara";

hp_max = 90;
hp = hp_max;
hp_visual = hp;

ataque1_nome = "Gotas D'Água";
ataque1_tipo = "cura";
ataque1_alvo = "aliado_um";
ataque1_valor = 28;
ataque1_efeito = "purificar";
ataque1_chance = 100;
ataque1_turnos = 0;
ataque1_efeito_valor = 0;

ataque2_nome = "Cura Total";
ataque2_tipo = "cura";
ataque2_alvo = "aliado_todos";
ataque2_valor = 16;


// Heróis ficam à esquerda olhando para a direita
escala_sprite = 2;
image_xscale = -escala_sprite;
image_yscale = escala_sprite;

x_original = x;
y_original = y;
