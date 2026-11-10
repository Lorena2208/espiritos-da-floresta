// SACI-PERERÊ - CONTROLE
event_inherited();

nome = "Saci-Pererê";

hp_max = 95;
hp = hp_max;
hp_visual = hp;

ataque1_nome = "Rasteira";
ataque1_tipo = "dano";
ataque1_alvo = "inimigo_um";
ataque1_valor = 26;

ataque2_nome = "Redemoinho";
ataque2_tipo = "dano";
ataque2_alvo = "inimigo_todos";
ataque2_valor = 10;
ataque2_efeito = "atordoar";
ataque2_chance = 40;
ataque2_turnos = 1;
ataque2_efeito_valor = 0;


// Heróis ficam à esquerda olhando para a direita
escala_sprite = 2;
image_xscale = -escala_sprite;
image_yscale = escala_sprite;

x_original = x;
y_original = y;
