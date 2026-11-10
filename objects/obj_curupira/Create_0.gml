// CURUPIRA - TANQUE / PROTETOR
event_inherited();

nome = "Curupira";

hp_max = 170;
hp = hp_max;
hp_visual = hp;

ataque1_nome = "Pegadas Invertidas";
ataque1_tipo = "dano";
ataque1_alvo = "inimigo_um";
ataque1_valor = 22;
ataque1_efeito = "confundir";
ataque1_chance = 100;
ataque1_turnos = 2;
ataque1_efeito_valor = 0;

ataque2_nome = "Proteção da Mata";
ataque2_tipo = "escudo";
ataque2_alvo = "aliado_todos";
ataque2_valor = 0;
ataque2_efeito = "escudo";
ataque2_chance = 100;
ataque2_turnos = 1;
ataque2_efeito_valor = 0;


// Heróis ficam à esquerda olhando para a direita
escala_sprite = 2;
image_xscale = -escala_sprite;
image_yscale = escala_sprite;

x_original = x;
y_original = y;
