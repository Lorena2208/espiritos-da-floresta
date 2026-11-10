// CHEFE DA FASE 2
event_inherited();

nome = "Draga Poluidora";

hp_max = 160;
hp = hp_max;
hp_visual = hp;

ataque_dano = 16;
ataque_nome = "Jato de Lama";

// Ataque especial a cada 3 turnos (atinge toda a equipe)
ataque_especial_nome = "Lama Tóxica";
ataque_especial_dano = 32;
ataque_especial_turnos = 3;
ataque_especial_texto = " na retaguarda!";

// Chefe: placa de vida no topo da tela
eh_chefe = true;
chefe_x = 760;
chefe_y = 226;

// Inimigos ficam à direita olhando para a esquerda
escala_sprite = 2;
image_xscale = -escala_sprite;
image_yscale = escala_sprite;

x_original = x;
y_original = y;
