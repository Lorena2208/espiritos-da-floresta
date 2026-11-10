// ==========================================
// VAGAS NA EQUIPE
// 3 vagas no começo; 4 quando o elenco chega a 4 lendas
// ==========================================

vagas = equipe_vagas();


// ==========================================
// TAMANHO DOS CARDS DA EQUIPE
// ==========================================

card_largura = 150;
card_altura = 150;

equipe_y = 132;

// slots centralizados no painel
var _gap = (vagas == 4) ? 55 : 125;
var _total = vagas * card_largura + (vagas - 1) * _gap;
var _x0 = 480 - _total / 2;

slots_x = [];

for (var i = 0; i < vagas; i++)
{
    array_push(slots_x, _x0 + i * (card_largura + _gap));
}


// ==========================================
// PERSONAGENS DISPONÍVEIS (uma linha com todos)
// ==========================================

n_personagens = array_length(global.personagens);

personagem_largura = 128;
personagem_altura = 118;
personagem_y = 330;

var _gap_p = 10;
var _total_p = n_personagens * personagem_largura + (n_personagens - 1) * _gap_p;
var _px0 = 480 - _total_p / 2;

personagens_x = [];

for (var i = 0; i < n_personagens; i++)
{
    array_push(personagens_x, _px0 + i * (personagem_largura + _gap_p));
}


// ==========================================
// BOTÕES
// ==========================================

botao_comecar_x = 760;
botao_comecar_y = 462;

botao_comecar_largura = 150;
botao_comecar_altura = 44;

botao_voltar_x = 50;
botao_voltar_y = 462;

botao_voltar_largura = 150;
botao_voltar_altura = 44;


// ==========================================
// SLOTS DA EQUIPE (-1 = vazio)
// Começa com a última equipe usada
// ==========================================

slots = array_create(vagas, -1);

if (variable_global_exists("equipe"))
{
    var _k = 0;

    for (var i = 0; i < array_length(global.equipe) && _k < vagas; i++)
    {
        var _id = global.equipe[i];

        if (_id >= 0 && _id < n_personagens && global.personagens[_id].desbloqueado)
        {
            slots[_k] = _id;
            _k++;
        }
    }
}


// Está na equipe?
na_equipe = function(_id)
{
    for (var i = 0; i < vagas; i++)
    {
        if (slots[i] == _id)
        {
            return true;
        }
    }

    return false;
};


// Equipe tem alguém?
equipe_ok = function()
{
    for (var i = 0; i < vagas; i++)
    {
        if (slots[i] != -1)
        {
            return true;
        }
    }

    return false;
};
