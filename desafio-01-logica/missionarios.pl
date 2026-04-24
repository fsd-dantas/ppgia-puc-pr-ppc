% Problema dos Missionários e Canibais — busca DFS em Prolog
%
% Estado: estado(M, C, Barco)
%   M     = missionários na margem esquerda  (0..3)
%   C     = canibais na margem esquerda      (0..3)
%   Barco = e (esquerda) | d (direita)
%
% Segurança: em nenhuma margem canibais superam missionários
% quando há missionários nessa margem.

% --- estado inicial e final ---

inicial(estado(3, 3, e)).
final(estado(0, 0, d)).

% --- restrição de segurança ---

seguro(M, C) :-
    Mr is 3 - M, Cr is 3 - C,
    (M  =:= 0 ; M  >= C),
    (Mr =:= 0 ; Mr >= Cr).

% --- operadores ---
% Cada cláusula representa uma travessia possível (1 ou 2 ocupantes).

% Esquerda → direita: subtrai da margem esquerda
mover(estado(M, C, e), estado(M1, C1, d)) :-
    member(DM-DC, [1-0, 2-0, 0-1, 0-2, 1-1]),
    M1 is M - DM, C1 is C - DC,
    M1 >= 0, C1 >= 0,
    seguro(M1, C1).

% Direita → esquerda: adiciona à margem esquerda
mover(estado(M, C, d), estado(M1, C1, e)) :-
    member(DM-DC, [1-0, 2-0, 0-1, 0-2, 1-1]),
    M1 is M + DM, C1 is C + DC,
    M1 =< 3, C1 =< 3,
    seguro(M1, C1).

% --- busca DFS com controle de visitados ---

solve(Ini, Fin, Caminho) :-
    dfs(Ini, Fin, [Ini], Caminho).

dfs(Estado, Estado, _, [Estado]).
dfs(Estado, Final, Visitados, [Estado|Resto]) :-
    mover(Estado, Prox),
    \+ member(Prox, Visitados),
    dfs(Prox, Final, [Prox|Visitados], Resto).

% --- ponto de entrada ---

:- initialization(main, main).

main :-
    inicial(Ini), final(Fin),
    (   solve(Ini, Fin, Caminho)
    ->  length(Caminho, N), Passos is N - 1,
        format("Solucao: ~w passos~n~n", [Passos]),
        forall(member(E, Caminho), (write(E), nl))
    ;   write("Sem solucao encontrada."), nl
    ).
