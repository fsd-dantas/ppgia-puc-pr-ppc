# Desafio 3 — Análise de Complexidade

Análise do espaço de estados e complexidade dos algoritmos de busca
aplicados ao problema dos missionários e canibais (3M + 3C, bote para 2).

---

## 1. Modelagem dos estados

O estado é a tripla `(M, C, B)`:
- `M` ∈ {0, 1, 2, 3} — missionários na margem esquerda
- `C` ∈ {0, 1, 2, 3} — canibais na margem esquerda
- `B` ∈ {E, D} — posição do bote

**Estado inicial:** `(3, 3, E)` — **Estado final:** `(0, 0, D)`

---

## 2. Contagem de estados

**Espaço total:** 4 × 4 × 2 = **32 estados possíveis**

**Estados válidos** — restrição: em nenhuma margem C > M quando M > 0.
Marginalmente válidos na esquerda e equivalente espelhado na direita:

| Esquerda (M, C) válidos com M > 0 | Válidos com M = 0 |
|---|---|
| (1,0), (1,1), (2,0), (2,1), (2,2), (3,0), (3,1), (3,2), (3,3) | (0,0), (0,1), (0,2), (0,3) |

Total de pares (M, C) válidos: 9 + 4 = **13 pares**  
Com 2 posições de bote: 13 × 2 = **26 estados válidos**

Na prática a busca DFS encontra solução em **12 estados distintos visitados** (11 transições).

---

## 3. Fator de ramificação

O bote transporta 1 ou 2 ocupantes; há 5 combinações: `{1M, 2M, 1C, 2C, 1M+1C}`.  
Nem todos são aplicáveis em todo estado (restrições de disponibilidade e segurança).

- **Fator de ramificação médio (b):** aproximadamente **2–3** neste domínio
- **Fator de ramificação máximo:** 5 (quando todas as 5 opções são válidas)

---

## 4. Crescimento do espaço de busca

| Algoritmo | Tempo | Espaço |
|---|---|---|
| BFS | O(b^d) | O(b^d) |
| DFS | O(b^m) | O(b·m) |

Onde `b` = fator de ramificação, `d` = profundidade da solução ótima, `m` = profundidade máxima.

**Neste domínio:**
- `d` = 11 (solução ótima encontrada)
- `m` ≤ 11 (espaço finito — ciclos controlados por lista de visitados)
- `b` ≈ 2–3

Com `b = 3` e `d = 11`: BFS explora até 3^11 = **177.147 nós** no pior caso,
mas a poda por estados visitados reduz para ≤ 26 estados únicos.

Na prática ambos os algoritmos são **O(|V| + |E|)** = O(26 + ~52) = **O(1)** (constante)
para qualquer instância do problema 3×3, pois o espaço de estados é fixo e pequeno.

---

## 5. Comparação DFS vs BFS neste domínio

| Critério | DFS | BFS |
|---|---|---|
| Completude | Sim (com controle de visitados) | Sim |
| Otimalidade | Não garante caminho mínimo | Garante caminho mínimo |
| Memória | O(b·m) — linear na profundidade | O(b^d) — exponencial |
| Velocidade na prática | Mais rápido (encontra solução cedo) | Mais lento (explora por nível) |

**Conclusão:** para o problema 3×3 os dois algoritmos são equivalentes na prática
dado o espaço reduzido. Em instâncias maiores (N missionários, N canibais) o espaço
cresce polinomialmente — O(N²) estados — mas o fator de ramificação cresce com N,
tornando BFS cada vez mais custoso em memória frente ao DFS.
