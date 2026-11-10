// BOITATÁ - QUEIMADURA (dano contínuo)
event_inherited();

nome = "Boitatá";

hp_max = 120;
hp = hp_max;
hp_visual = hp;

ataque1_nome = "Fogo-Fátuo";
ataque1_tipo = "dano";
ataque1_alvo = "inimigo_um";
ataque1_valor = 16;
ataque1_efeito = "queimar";
ataque1_chance = 100;
ataque1_turnos = 3;
ataque1_efeito_valor = 8;

ataque2_nome = "Rastro de Fogo";
ataque2_tipo = "dano";
ataque2_alvo = "inimigo_todos";
ataque2_valor = 10;
ataque2_efeito = "queimar";
ataque2_chance = 100;
ataque2_turnos = 2;
ataque2_efeito_valor = 5;


// Heróis ficam à esquerda olhando para a direita
escala_sprite = 2;
image_xscale = -escala_sprite;
image_yscale = escala_sprite;

x_original = x;
y_original = y;
