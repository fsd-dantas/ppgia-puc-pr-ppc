# Referência: Problema dos Jarros de Água

Material de referência fornecido pelo professor — modelo de estados e operadores
usado como base para os desafios 1 (Prolog) e 2 (LISP).

## Descrição

Dois jarros com capacidades distintas:
- Jarro 1: 3 litros
- Jarro 2: 4 litros

**Objetivo:** fazer o jarro de 4 litros ficar com exatamente 2 litros.
O jarro de 3 litros pode terminar em qualquer estado.

## Estado

`[X, Y]` onde `X` = litros no jarro de 3L, `Y` = litros no jarro de 4L.

Estado inicial: `[0, 0]`  
Estado final: `[_, 2]`

## Operadores (8 operações possíveis)

| # | Operação |
|---|---|
| 1 | Encher o jarro 1 (3L) |
| 2 | Encher o jarro 2 (4L) |
| 3 | Esvaziar o jarro 1 |
| 4 | Esvaziar o jarro 2 |
| 5 | Transferir todo o conteúdo do jarro 1 para o jarro 2 |
| 6 | Transferir todo o conteúdo do jarro 2 para o jarro 1 |
| 7 | Transferir do jarro 1 para o jarro 2 até encher o 2 (sobra no 1) |
| 8 | Transferir do jarro 2 para o jarro 1 até encher o 1 (sobra no 2) |

## Exemplo de solução

```prolog
?- solve([0,0], X).
X = [[3,0], [3,4], [0,4], [3,1], [0,1], [1,0], [1,4], [3,2]]
```
