// CHEFÃO FINAL - O DEVORADOR DE FLORESTAS
event_inherited();

nome = "O Devorador";

hp_max = 700;
hp = hp_max;
hp_visual = hp;

ataque_dano = 38;
ataque_nome = "Lâminas Giratórias";

// Ataque especial a cada 3 turnos (atinge toda a equipe)
ataque_especial_nome = "Fumaça Negra";
ataque_especial_dano = 26;
ataque_especial_turnos = 3;
ataque_especial_efeito = "queimar";
ataque_especial_chance = 100;
ataque_especial_efeito_turnos = 2;
ataque_especial_efeito_valor = 8;

// Chefe: placa de vida no topo da tela
eh_chefe = true;
chefe_x = 780;
chefe_y = 236;
invoca_obj = obj_capanga;
invoca_turnos = 3;
invoca_max = 3;
invoca_total = 2;
furia_limite = 0.5;
hud_chefe_larg = 280;

// Inimigos ficam à direita olhando para a esquerda
escala_sprite = 1.75;
image_xscale = -escala_sprite;
image_yscale = escala_sprite;

x_original = x;
y_original = y;
