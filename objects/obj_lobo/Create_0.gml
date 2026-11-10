// LOBISOMEM - DPS
event_inherited();

nome = "Lobisomem";

hp_max = 150;
hp = hp_max;
hp_visual = hp;

ataque1_nome = "Garras";
ataque1_tipo = "dano";
ataque1_alvo = "inimigo_um";
ataque1_valor = 20;

ataque2_nome = "Mordida";
ataque2_tipo = "dano";
ataque2_alvo = "inimigo_um";
ataque2_valor = 35;


// Heróis ficam à esquerda olhando para a direita
escala_sprite = 2;
image_xscale = -escala_sprite;
image_yscale = escala_sprite;

// sprite original não tem sombra própria
sombra = true;

x_original = x;
y_original = y;
