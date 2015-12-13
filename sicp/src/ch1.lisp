(in-package :sicp)

;;; Ex 1.1
;; 10 -> 10
;; (+ 5 3 4) -> 12
;; (- 9 1) -> 8
;; (/ 6 2) -> 3
;; (+ (* 2 4) (- 4 6)) -> 6
;; (defparameter a 3) -> a
;; (defparameter b (+ a 1)) -> b
;; (+ a b (* a b)) -> 19
;; (= a b) -> nil
;; (if (and (> b a) (< b (* a b))) b a) -> b
;; (cond ((= a 4) 6)
;;       ((= b 4) (+ 6 7 a))  -> 16
;;       (t 25)) 
;; (+ 2 (if (> b a) b a)) -> 6
;; (* (cond ((> a b) a)
;;                 ((< a b) b)  -> 16
;;                 (else -1))  
;;           (+ a 1))

;;; Ex 1.2
(/ (+ 5 4 (- 2 (- 3 (+ 6 4/5))))
   (* 3 (- 6 2) (- 2 7)))

;;; Ex 1.3
(defun sum-of-square (a b)
  (+ (* a a) (* b b)))
(defun square-of-larger (a b c)
  (if (< a b)
      (if (< a c)
	  (sum-of-square b c)
	  (sum-of-square a b))
      (if (< b c)
	  (sum-of-square a c)
	  (sum-of-square a b))))

;;; Ex 1.4
;; b>0时 a+b b<0时 a-b

;;; Ex 1.5
;; (define (p) (p))
;; (define (test x y)
;;     (if (= x 0) 0 y))
;; (test 0 (p))
;; (if (= 0 0) 0 (p))
;; applicative-order: 返回0 并不求值(p)
;; normal-order: 死循环 求值(p)

;;; Ex 1.6
;; (define (new-if predicate then-clause else-clause)
;;     (cond (predicate then-clause)
;; 	  (else else-clause)))

;; (define (sqrt-iter guess x)
;;      (new-if (good-enough? guess x)
;;              guess
;;              (sqrt-iter (improve guess x) x)))
;; 由于new-if是普通函数,lisp求值new-if时会分别求值3个参数(applicative-order)
;; 当求值else-clause时也就是对sqrt-iter求值,这里是个死循环

;;; Ex 1.7
;; (defun good-enough-p (guess x)
;;   (< (abs (- (* guess guess) x)) 0.001))
(defun good-enough-p (old new)
  (> 0.0000001 (/ (abs (- old new)) old)))
(defun improve (guess x)
  (/ (+ guess (/ x guess)) 2))
(defun sqrt-iter (guess x)
  (if (good-enough-p guess (improve guess x))
      (improve guess x)
      (sqrt-iter (improve guess x) x)))
(defun sicp-sqrt (n)
  (sqrt-iter 1.0 n))

;;; Ex 1.8
(defun cube-root (n)
  (labels ((improve (guess x)
	     (/ (+ (/ x (* guess guess)) guess guess) 3))
	   (cube-root-iter (guess x)
	     (if (good-enough-p guess (improve guess x))
		 (improve guess x)
		 (cube-root-iter (improve guess x) x))))
    (cube-root-iter 1.0 n)))

;;; Ex 1.9
;; (define (+ a b)
;;     (if (= a 0)
;; 	b
;; 	(inc (+ (dec a) b))))

;; (+ 4 5)
;; (if (= 4 0)
;;     5
;;     (inc (+ 3 5)))
;; (inc (if (= 3 0)
;; 	 5
;; 	 (inc (+ 2 5))))
;; (inc (inc (if (= 2 0)
;; 	      5
;; 	      (inc (+ 1 5)))))
;; (inc (inc (inc (if (= 1 0)
;; 		   5
;; 		   (inc (+ 0 5))))))
;; (inc (inc (inc (inc 5))))
;; (inc (inc (inc 6)))
;; (inc (inc 7))
;; (inc 8)
;; 9
;; 递归过程

;; (define (+ a b)
;;     (if (= a 0)
;; 	b
;; 	(+ (dec a) (inc b))))

;; (+ 4 5)
;; (if (= 4 0)
;;     5
;;     (+ 3 6))
;; (+ 3 6)
;; (if (= 3 0)
;;     6
;;     (+ 2 7))
;; (+ 2 7)
;; (if (= 2 0)
;;     7
;;     (+ 1 8))
;; (+ 1 8)
;; (if (= 1 0)
;;     8
;;     (+ 0 9))
;; (+ 0 9)
;; (if (= 0 0)
;;     9
;;     ...)
;; 9
;; 迭代过程

;;; Ex 1.10
(defun A (x y)
  (cond ((= y 0) 0)
	((= x 0) (* 2 y))
	((= y 1) 2)
	(t (A (- x 1) (A x (- y 1))))))

;; (A 1 10) -> 1024
;; (A 2 4)  -> 65536
;; (A 3 3)  -> 65536

;; (define (f n) (A 0 n))
;; (f n) 2n
;; (define (g n) (A 1 n))
;; (g n) 2^n
;; (define (h n) (A 2 n))
;; (h n) 2^(2^(2...2))  n个2

;;; Ex 1.11
(defun f-recur (n)
  (if (< n 3)
      n
      (+ (f-recur (- n 1))
	 (* 2 (f-recur (- n 2)))
	 (* 3 (f-recur (- n 3))))))

(defun f-iter (n)
  (labels ((f (i n-1 n-2 n-3)
	     (let ((curr (+ (* 3 n-1) (* 2 n-2) n-3)))
	       (if (= n i)
		   curr
		   (f (1+ i) n-2 n-3 curr)))))
    (if (< n 3)
	n
	(f 4 1 2 4))))

;;; Ex 1.12
(defun pascal (n)
  (labels ((horizontal (lst)
	     (if (null (cdr lst))
		 lst
		 (cons (+ (first lst) (second lst))
		       (horizontal (cdr lst)))))
	   (vertical (n)
	     (if (= n 1)
		 (progn
		   (prin1 '(1))
		   '(1))
		 (let ((curr (cons 1 (horizontal (vertical (1- n))))))
		   (print curr)))))
    (vertical n)))

;;; Ex 1.13
;; 根据提示首先证明Fib(n) = (φ^n - γ^n)/sqrt(5)
;; 数学归纳法
;; φ ＝ (1+sqrt(5))/2              φ^2 = φ + 1     (1)
;; 现取 γ ＝ (1-sqrt(5))/2 则可以算出 γ^2 = γ ＋ 1     (2)
;; Fib(0) = 0 = (φ^0 - γ^0)/sqrt(5) = 0/sqrt(5)
;; Fib(1) = 1 = (φ^1 - γ^1)/sqrt(5) = 1
;; Fib(n) = (φ^n - γ^n)/sqrt(5)
;; 则
;; Fib(n+1) = Fib(n) + Fib(n-1)
;;          = (φ^n - γ^n)/sqrt(5) + (φ^(n-1) - γ^(n-1))/sqrt(5)
;;          = (φ^(n-1)(φ + 1) - γ^(n-1)(γ + 1)) / sqrt(5)
;; 代入 (1) (2)
;;          = (φ^(n+1) - γ^(n+1))/sqrt(5)
;; 所以得证 Fib(n) = (φ^n - γ^n)/sqrt(5)
;; Fib(n) = φ^n/sqrt(5) - γ^n/sqrt(5)
;; γ ＝ (1-sqrt(5))/ 可以推出 -1 < y/sqrt(5) < 0
;; 所以Fib(n)为最接近φ^n/sqrt(5)的整数

;;; Ex 1.14
;; 11美分从10美分开始计算 所以为(cc amount 3) 节约空间 去掉为0的叶子
;;                  (cc 11 3)
;;                    /    \
;;             (cc 1 3)  (cc 11 2)
;;               |         /     \
;;          (cc 1 2)  (cc 11 1)  (cc 6 2)
;;               |        |        /      \
;;          (cc 1 1)  (cc 10 1)  (cc 6 1) (cc 1 2)
;;               |        |         |          |
;;          (cc 0 1)      .         .     (cc 1 1)     
;;               |        .         .          |
;;               1        .         .          1
;;                     (cc 1 1)  (cc 1 1)
;;                        |         |
;;                        1         1
;; (cc 11 3) -> 4 和图的结果一致
;; 步数正比于结点树(包括为0的结点) 空间为正比最大深度

;;; Ex 1.15
(defun cube (x) (* x x x))
(defun p (x) (- (* 3 x) (* 4 (cube x))))
(defun sine (angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

;; (sine 12.15) 5次
;; O(logN) 每次都变为1/3

;;; Ex 1.16

;;; Ex 1.34
;; (defun f (g)
;;   (g 2))
;; (f f)
;; (f 2)
;; (2 2) -> error

