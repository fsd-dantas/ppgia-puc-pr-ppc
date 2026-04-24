# Desafio 1 — Programação Lógica (Prolog)

Solver DFS para o problema dos missionários e canibais em SWI-Prolog.

## Representação de estados

`estado(M, C, Barco)` onde `M` = missionários na margem esquerda (0–3),
`C` = canibais na margem esquerda (0–3), `Barco` = `e` (esquerda) ou `d` (direita).

- Estado inicial: `estado(3, 3, e)`
- Estado final: `estado(0, 0, d)`

## Operadores

5 movimentos possíveis por direção de travessia: 1M, 2M, 1C, 2C, 1M+1C.
Restrição: em nenhuma margem canibais superam missionários quando há missionários.

## Execução

```bash
swipl -t halt missionarios.pl
```

## Solução encontrada (11 passos)

```
estado(3,3,e) → estado(3,1,d) → estado(3,2,e) → estado(3,0,d) →
estado(3,1,e) → estado(1,1,d) → estado(2,2,e) → estado(0,2,d) →
estado(0,3,e) → estado(0,1,d) → estado(1,1,e) → estado(0,0,d)
```
