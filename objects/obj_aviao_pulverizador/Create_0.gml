// CHEFE DA FASE 5 - AVIÃO PULVERIZADOR
event_inherited();

nome = "Avião Pulverizador";

hp_max = 500;
hp = hp_max;
hp_visual = hp;

ataque_dano = 32;
ataque_nome = "Rasante";

// Ataque especial a cada 3 turnos (atinge toda a equipe)
ataque_especial_nome = "Nuvem de Veneno";
ataque_especial_dano = 22;
ataque_especial_turnos = 3;
ataque_especial_efeito = "envenenar";
ataque_especial_chance = 100;
ataque_especial_efeito_turnos = 2;
ataque_especial_efeito_valor = 6;

// Chefe: placa de vida no topo da tela
eh_chefe = true;
chefe_x = 770;
chefe_y = 214;

// Inimigos ficam à direita olhando para a esquerda
escala_sprite = 2;
image_xscale = -escala_sprite;
image_yscale = escala_sprite;

x_original = x;
y_original = y;
