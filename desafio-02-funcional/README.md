# Desafio 2 — Programação Funcional (LISP)

Solver DFS para o problema dos missionários e canibais em Common Lisp.

## Representação de estados

Lista `(M C BARCO)` onde `M` = missionários na margem esquerda (0–3),
`C` = canibais na margem esquerda (0–3), `BARCO` = `:E` ou `:D`.

- Estado inicial: `(3 3 :E)`
- Estado final: `(0 0 :D)`

## Paradigma funcional

Implementação puramente funcional: sem atribuição destrutiva, sem laços.
- `SUCESSORES` — gera lista de próximos estados via `MAPCAR` + `REMOVE`
- `DFS` — recursão com `SOME` para exploração da árvore de busca
- Controle de visitados por lista imutável passada como argumento

## Execução

```bash
# SBCL
sbcl --script missionarios.lisp

# CLISP
clisp missionarios.lisp
```

## Solução encontrada (11 passos)

```
(3 3 E) → (3 1 D) → (3 2 E) → (3 0 D) →
(3 1 E) → (1 1 D) → (2 2 E) → (0 2 D) →
(0 3 E) → (0 1 D) → (1 1 E) → (0 0 D)
```
