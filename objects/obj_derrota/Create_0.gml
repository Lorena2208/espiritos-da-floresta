
botao_largura = 300;
botao_altura = 56;

botao_tentar_x = 330;
botao_tentar_y = 296;

botao_equipe_x = 330;
botao_equipe_y = 364;

botao_menu_x = 330;
botao_menu_y = 432;


// Dica sorteada para a próxima tentativa
var _dicas = [
    "Dica: a Iara cura a equipe e remove fogo e veneno.",
    "Dica: o Curupira protege o time com a Proteção da Mata.",
    "Dica: Matinta, Boitatá e Saci atacam vários inimigos de uma vez.",
    "Dica: derrote primeiro os inimigos mais fracos.",
    "Dica: o Redemoinho do Saci pode atordoar os inimigos.",
    "Dica: experimente outra formação de equipe."
];

dica = _dicas[irandom(array_length(_dicas) - 1)];
