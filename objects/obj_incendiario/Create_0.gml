// INCENDIÁRIO (fase 3)
event_inherited();

nome = "Incendiário";

hp_max = 90;
hp = hp_max;
hp_visual = hp;

ataque_dano = 16;
ataque_nome = "Tocha";
ataque_efeito = "queimar";
ataque_efeito_chance = 50;
ataque_efeito_turnos = 2;
ataque_efeito_valor = 8;

// Inimigos ficam à direita olhando para a esquerda
escala_sprite = 2;
image_xscale = -escala_sprite;
image_yscale = escala_sprite;

x_original = x;
y_original = y;
