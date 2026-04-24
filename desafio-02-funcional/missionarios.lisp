;;; Problema dos Missionários e Canibais — busca DFS em Common Lisp
;;;
;;; Estado: lista (M C BARCO)
;;;   M     = missionários na margem esquerda  (0..3)
;;;   C     = canibais na margem esquerda      (0..3)
;;;   BARCO = :E (esquerda) | :D (direita)

;;; --- representação de estado ---

(defun make-state (m c barco) (list m c barco))
(defun m     (s) (first  s))
(defun c     (s) (second s))
(defun barco (s) (third  s))

(defparameter *inicial* (make-state 3 3 :E))
(defparameter *final*   (make-state 0 0 :D))

;;; --- segurança ---

(defun seguro-p (m c)
  "Verdadeiro se o estado com M missionários e C canibais na esquerda é seguro."
  (let ((mr (- 3 m)) (cr (- 3 c)))
    (and (or (= m  0) (>= m  c))
         (or (= mr 0) (>= mr cr)))))

;;; --- movimentos possíveis ---

(defparameter *delta* '((1 0) (2 0) (0 1) (0 2) (1 1)))

(defun sucessores (estado)
  "Retorna lista de estados alcançáveis a partir de ESTADO em um passo."
  (let ((m (m estado)) (c (c estado)) (b (barco estado)))
    (remove nil
      (mapcar (lambda (d)
                (let* ((dm (first d)) (dc (second d))
                       (m1 (if (eq b :E) (- m dm) (+ m dm)))
                       (c1 (if (eq b :E) (- c dc) (+ c dc)))
                       (b1 (if (eq b :E) :D :E)))
                  (when (and (>= m1 0) (<= m1 3)
                             (>= c1 0) (<= c1 3)
                             (seguro-p m1 c1))
                    (make-state m1 c1 b1))))
              *delta*))))

;;; --- busca DFS ---

(defun dfs (estado final visitados)
  "Retorna caminho (lista de estados) de ESTADO até FINAL, ou NIL."
  (cond
    ((equal estado final) (list estado))
    (t (some (lambda (prox)
               (unless (member prox visitados :test #'equal)
                 (let ((resto (dfs prox final (cons prox visitados))))
                   (when resto (cons estado resto)))))
             (sucessores estado)))))

(defun solve ()
  (dfs *inicial* *final* (list *inicial*)))

;;; --- ponto de entrada ---

(defun formatar-estado (s)
  (format t "estado(~a, ~a, ~a)~%" (m s) (c s) (barco s)))

(defun main ()
  (let ((caminho (solve)))
    (if caminho
        (progn
          (format t "Solucao: ~a passos~%~%" (1- (length caminho)))
          (mapc #'formatar-estado caminho))
        (format t "Sem solucao encontrada.~%"))))

(main)
