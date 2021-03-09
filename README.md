
[<img src="https://raw.githubusercontent.com/alemaocastro1986/ignite-challenge-one/main/assets/elixir_full.png" width="180"/>]() 
# Chapter I - Aprofundando conceitos
## Sobre
Trilha Elixir Ignite [Rocketseat](https://rocketseat.com.br/)  __Chapter I__ .

Este projeto tem por objetivo ler arquivos `.csv` com quantidade de registros entre 100k e 300k, com dados referentes a compras de comida por ususário, e com isso gerar reports de quantidade gasta em compras por usuário e pratos mais requisitados.

Neste projeto foram foram aplicados os seguintes coinceitos:
- Leitura de arquivos com `File.stream`;
- Manipulação de dados com `Stream` e `Enum`
- Criação e execução de Tasks em paralelo;
- Separação de reponsabilidades;
- Pipe Operator;
- Pattern Match;
- Guards
- Funções anônimas
- Utilização do module `:timer` do Erlang para verificar performance de execução sem paralelismo e com paralelismo;
- Tests


## Testando
```bash
mix test
```