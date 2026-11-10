// Congela animações enquanto o jogo está pausado
if (global.pausado)
{
    exit;
}

// Inimigo derrotado: some aos poucos
if (morrendo)
{
    morte_timer++;

    image_alpha = max(0, 1 - morte_timer / 20);

    if (morte_timer >= 20)
    {
        instance_destroy();
    }

    exit;
}

if (dano_timer > 0)
{
    dano_timer--;
}

if (efeito_dano_timer > 0)
{
    efeito_dano_timer--;
}
else
{
    efeito_dano = false;
}

// dir_ataque: heróis avançam para a direita (+1), inimigos para a esquerda (-1)

if (animacao_combate == "ataque")
{
    animacao_timer++;

    if (animacao_timer <= 18)
    {
        x = x_original + (movimento_ataque * dir_ataque);
    }
    else if (animacao_timer <= 28)
    {
        var progresso = (animacao_timer - 18) / 10;

        x = x_original + (movimento_ataque * dir_ataque) * (1 - progresso);
    }
    else
    {
        animacao_combate = "normal";
        animacao_timer = 0;
        x = x_original;
    }
}

if (animacao_combate == "dano")
{
    animacao_timer++;

    if (animacao_timer <= 14)
    {
        x = x_original - (movimento_dano * dir_ataque);
    }
    else if (animacao_timer <= 24)
    {
        var progresso = (animacao_timer - 14) / 10;

        x = x_original - (movimento_dano * dir_ataque) * (1 - progresso);
    }
    else
    {
        animacao_combate = "normal";
        animacao_timer = 0;
        x = x_original;
    }
}
