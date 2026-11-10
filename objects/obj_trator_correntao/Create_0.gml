// CHEFE DA FASE 3 - TRATOR DO CORRENTÃO
event_inherited();

nome = "Trator do Correntão";

hp_max = 380;
hp = hp_max;
hp_visual = hp;

ataque_dano = 30;
ataque_nome = "Esmagar";

// Ataque especial a cada 3 turnos (atinge toda a equipe)
ataque_especial_nome = "Correntão";
ataque_especial_dano = 26;
ataque_especial_turnos = 3;
ataque_especial_texto = " arrastando toda a equipe!";

// Chefe: placa de vida no topo da tela
eh_chefe = true;
chefe_x = 750;
chefe_y = 236;

// Inimigos ficam à direita olhando para a esquerda
escala_sprite = 2;
image_xscale = -escala_sprite;
image_yscale = escala_sprite;

x_original = x;
y_original = y;
