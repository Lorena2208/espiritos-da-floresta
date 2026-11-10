// TRAFICANTE DE ANIMAIS (fase 4)
event_inherited();

nome = "Traficante";

hp_max = 85;
hp = hp_max;
hp_visual = hp;

ataque_dano = 15;
ataque_nome = "Armadilha";
ataque_efeito = "atordoar";
ataque_efeito_chance = 30;
ataque_efeito_turnos = 1;
ataque_efeito_valor = 0;

// Inimigos ficam à direita olhando para a esquerda
escala_sprite = 2;
image_xscale = -escala_sprite;
image_yscale = escala_sprite;

x_original = x;
y_original = y;
