// ==========================================
// TELA FINAL (depois do chefão)
// ==========================================

botao_largura = 300;
botao_altura = 52;

botao_x = 330;
botao_y = 452;

// lendas lado a lado
sprites_final = [];

for (var i = 0; i < array_length(global.personagens); i++)
{
    array_push(sprites_final, global.personagens[i].sprite);
}
