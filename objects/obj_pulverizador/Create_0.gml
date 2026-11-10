// PULVERIZADOR (fase 5)
event_inherited();

nome = "Pulverizador";

hp_max = 90;
hp = hp_max;
hp_visual = hp;

ataque_dano = 15;
ataque_nome = "Spray Tóxico";
ataque_efeito = "envenenar";
ataque_efeito_chance = 60;
ataque_efeito_turnos = 3;
ataque_efeito_valor = 7;

// Inimigos ficam à direita olhando para a esquerda
escala_sprite = 2;
image_xscale = -escala_sprite;
image_yscale = escala_sprite;

x_original = x;
y_original = y;
