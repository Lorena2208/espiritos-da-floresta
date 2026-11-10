// CHEFE DA FASE 1
event_inherited();

nome = "Chefe do Crime";

hp_max = 125;
hp = hp_max;
hp_visual = hp;

ataque_dano = 30;

// Chefe: placa de vida no topo da tela
eh_chefe = true;
hud_chefe_dx = -150;
hud_chefe_y = 70;
hud_chefe_larg = 200;

// Inimigos ficam à direita olhando para a esquerda
escala_sprite = 2.5;
image_xscale = -escala_sprite;
image_yscale = escala_sprite;

sombra = true;

x_original = x;
y_original = y;
