// CHEFE DA FASE 4 - CONTRABANDISTA
event_inherited();

nome = "Contrabandista";

hp_max = 480;
hp = hp_max;
hp_visual = hp;

ataque_dano = 36;
ataque_nome = "Chicotada";

// Ataque especial a cada 3 turnos (atinge toda a equipe)
ataque_especial_nome = "Rede de Captura";
ataque_especial_dano = 28;
ataque_especial_turnos = 3;

// Chefe: placa de vida no topo da tela
eh_chefe = true;
chefe_x = 790;
chefe_y = 244;
invoca_obj = obj_cacador;
invoca_turnos = 3;
invoca_max = 3;
invoca_total = 2;

// Inimigos ficam à direita olhando para a esquerda
escala_sprite = 2;
image_xscale = -escala_sprite;
image_yscale = escala_sprite;

x_original = x;
y_original = y;
