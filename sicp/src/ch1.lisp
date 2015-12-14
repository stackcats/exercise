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
(defun fast-expt (b n)
  (labels ((iter (b n a)
	     (cond
	       ((zerop n) a)
	       ((evenp n) (iter (* b b) (/ n 2) a))
	       (t (iter b (1- n) (* a b))))))
    (iter b n 1)))

;;; Ex 1.17
(defun double (n) (* 2 n))
(defun halve (n) (/ n 2))
(defun fast-mul (a b)
  (cond
    ((= b 0) 0)
    ((= b 1) a)
    ((evenp b) (fast-mul (double a) (halve b)))
    (t  (+ a (fast-mul a (1- b))))))

;;; Ex 1.18
(defun fast-mul-iter (a b)
  (labels ((iter (a b n)
	     (cond
	       ((= a 0) n)
	       ((evenp a) (iter (halve a) (double b) n))
	       (t (iter (1- a) b (+ n b))))))
    (if (or (zerop a) (zerop b))
	0
	(iter a b 0))))

;;; Ex 1.19
;; b1 = bp + aq, a1 = bq + aq + ap
;; 分别求b2,a2

;; b2 = b1p + a1q 代入b1,a1
;;    = b(p^2 + q^2) + a(2pq + q^2)
;; 所以
;; b2 = bp'+aq' => p' = p^2 + q^2, q' = 2pq + q^2

;; a2 = b1q + a1q + a1p
;;    = b(2pq + q^2) + a(2pq + q^2) + a(p^2 + q^2)
;; a2 = bq' + aq' + ap' => p' = p^2 + q^2, q' = 2pq + q^2
;; a2和b2得到的p' q'一致所以当2次变换时p' = p^2 + q^2, q' = 2pq + q^2

(defun fib (n)
  (fib-iter 1 0 0 1 n))
(defun fib-iter (a b p q count)
  (cond
    ((zerop count) b)
    ((evenp count)
     (fib-iter a
	       b
	       (+ (* p p) (* q q))
	       (+ (* 2 p q) (* q q))
	       (halve count)))
    (t
     (fib-iter (+ (* b q) (* a q) (* a p))
	       (+ (* b p) (* a q))
	       p
	       q
	       (1- count)))))

;;; Ex 1.20
;; (defun gcd (a b)
;;   (if (zerop b)
;;       a
;;       (gcb b (mod a b))))
;; gcd(206 40)
;; 尝试展开normal-order
;; (if (zerop 40)
;;     206
;;     (gcd 40 (mod 206 40)))

;; (if (zerop 40)
;;     206
;;     (if (zerop (mod 206 40))
;; 	40
;; 	(gcd (mod 206 40) (mod 40 (mod 206 40)))))

;; (if (zerop 40)
;;     206
;;     (if (zerop (mod 206 40))
;; 	40
;; 	(if (zerop (mod 40 (mod 206 40)))
;; 	    (mod 206 40)
;; 	    (gcd (mod 40 (mod 206 40))
;; 		 (mod (mod 206 40) (mod 40 (mod 206 40)))))))

;; (if (zerop 40)
;;     206
;;     (if (zerop (mod 206 40))
;; 	40
;; 	(if (zerop (mod 40 (mod 206 40)))
;; 	    (mod 206 40)
;; 	    (if (zerop (mod (mod 206 40) (mod 40 (mod 206 40))))
;; 		(mod 40 (mod 206 40))
;; 		(gcd (mod (mod 206 40) (mod 40 (mod 206 40)))
;; 		     (mod (mod 40 (mod 206 40))
;; 			  (mod (mod 206 40)
;; 			       (mod 40 (mod 206 40)))))))))

;; (if (zerop 40)
;;     206
;;     (if (zerop (mod 206 40))
;; 	40
;; 	(if (zerop (mod 40 (mod 206 40)))
;; 	    (mod 206 40)
;; 	    (if (zerop (mod (mod 206 40) (mod 40 (mod 206 40))))
;; 		(mod 40 (mod 206 40))
;; 		(if (zerop (mod (mod 40 (mod 206 40)) ;已经等于0
;; 				(mod (mod 206 40)
;; 				     (mod 40 (mod 206 40)))))
;; 		    (mod (mod 206 40) (mod 40 (mod 206 40))))))))

;; 因为normal-order需要全部展开后再求值, 所以只检查上面最后一个表达式一共有21个mod的计算

;; 尝试展开applicative-order
;; (gcd 206 40)
;; (if (zerop 40)
;;     206
;;     (gcd 40 (mod 206 40)))

;; (gcd 40 6)
;; (if (zerop 6)
;;     40
;;     (gcd 6 (mod 40 6)))

;; (gcd 6 4)
;; (if (zerop 4)
;;     6
;;     (gcd 4 (mod 6 4)))

;; (gcd 4 2)
;; (if (zerop 2)
;;     4
;;     (gcd 2 (mod 4 2)))
;; (gcd 2 0)
;; (if (zerop 0) 2 ...)
;; 因为applicative-order先求值再展开, 所以需要检查上面所有表达式中的mod
;; 一共有4次mod计算

;;; Ex 1.21
(defun smallest-divisor (n)
  (find-divisor n 2))

(defun find-divisor (n test-divisor)
  (cond
    ((> (* test-divisor test-divisor) n) n)
    ((zerop (mod n test-divisor)) test-divisor)
    (t (find-divisor n (next test-divisor)))))
;; (smallest-divisor 199)   -> 199
;; (smallest-divisor 1999)  -> 1999
;; (smallest-divisor 19999) -> 7

;;; Ex 1.22
;; cl可以使用time检查运行时间
(defun prime-p (n)
  (if (< n 2)
      nil
      (= n (smallest-divisor n))))
;; 只取3个 运行速度太快 这里改成300个
(defun search-for-primes (a b)
  (labels ((helper (a b acc)
	     (cond
	       ((or (> a b) (= 300 (length acc))) (reverse acc))
	       ((prime-p a) (helper (+ 2 a) b (cons a acc)))
	       (t (helper (+ 2 a) b acc)))))
    (cond
      ((<= a 2) (cons 2 (helper 3 b nil)))
      ((zerop (mod a 2)) (helper (1+ a) b nil))
      (t (helper a b nil)))))

;; (SEARCH-FOR-PRIMES 1000 10000)
;; took 1 milliseconds (0.001 seconds) to run.
;; During that period, and with 8 available CPU cores,
;;      1 milliseconds (0.001 seconds) were spent in user mode
;;      0 milliseconds (0.000 seconds) were spent in system mode
;; 2,400 bytes of memory allocated.

;; (SEARCH-FOR-PRIMES 10000 100000)
;; took 2 milliseconds (0.002 seconds) to run.
;; During that period, and with 8 available CPU cores,
;;      2 milliseconds (0.002 seconds) were spent in user mode
;;      0 milliseconds (0.000 seconds) were spent in system mode
;; 2,400 bytes of memory allocated.

;; (SEARCH-FOR-PRIMES 100000 1000000)
;; took 3 milliseconds (0.003 seconds) to run.
;; During that period, and with 8 available CPU cores,
;;      4 milliseconds (0.004 seconds) were spent in user mode
;;      0 milliseconds (0.000 seconds) were spent in system mode
;; 2,400 bytes of memory allocated

;; (SEARCH-FOR-PRIMES 1000000 10000000)
;; took 11 milliseconds (0.011 seconds) to run.
;; During that period, and with 8 available CPU cores,
;;      11 milliseconds (0.011 seconds) were spent in user mode
;;       0 milliseconds (0.000 seconds) were spent in system mode
;; 2,400 bytes of memory allocated.

;;; Ex 1.23
(defun next (n)
  (if (= n 2)
      3
      (+ n 2)))

;; (SEARCH-FOR-PRIMES 1000 10000)
;; took 0 milliseconds (0.000 seconds) to run.
;; During that period, and with 8 available CPU cores,
;;      1 milliseconds (0.001 seconds) were spent in user mode
;;      0 milliseconds (0.000 seconds) were spent in system mode
;; 2,400 bytes of memory allocated

;; (SEARCH-FOR-PRIMES 10000 100000)
;; took 2 milliseconds (0.002 seconds) to run.
;; During that period, and with 8 available CPU cores,
;;      2 milliseconds (0.002 seconds) were spent in user mode
;;      0 milliseconds (0.000 seconds) were spent in system mode
;; 2,400 bytes of memory allocated

;; (SEARCH-FOR-PRIMES 100000 1000000)
;; took 3 milliseconds (0.003 seconds) to run.
;; During that period, and with 8 available CPU cores,
;;      3 milliseconds (0.003 seconds) were spent in user mode
;;      0 milliseconds (0.000 seconds) were spent in system mode
;; 2,400 bytes of memory allocated.

;; (SEARCH-FOR-PRIMES 1000000 10000000)
;; took 5 milliseconds (0.005 seconds) to run.
;; During that period, and with 8 available CPU cores,
;;      4 milliseconds (0.004 seconds) were spent in user mode
;;      0 milliseconds (0.000 seconds) were spent in system mode
;;  2,400 bytes of memory allocated.

;;; Ex 1.24
;;TODO:

;;; Ex 1.25
;; 结果正确,速度不行, Alyssa的expmod对于很大的数来说先生成一个很大的幂再取余数
;; 而原实现递归时利用了同余的概念,保持每次取余后都小于m

;;; Ex 1.26
;; 当exp为偶数时只计算一次(expmod base (/ exp 2))
;; 而Louis却计算了2次
;; 复杂度为O(log(n) + log(n)) = O(n)  (log(n)是以2为底)

;;; Ex 1.27
(defun expmod (base exp m)
  (cond
    ((= exp 0) 1)
    ((evenp exp)
     (mod (expt (expmod base (/ exp 2) m) 2)
	  m))
    (t
     (mod (* base (expmod base (- exp 1) m))
	  m))))
(defun carmichael-test (n)
  (labels ((try-it (a)
	     (= (expmod a n n) a)))
    (dotimes (i (1- n) t)
      (unless (try-it (1+ i))
	(return nil)))))

;;; Ex 1.28
;;TODO:

;;; Ex 1.29
(defun sum (term a next b)
  (if (> a b)
      0
      (+ (funcall term a)
	 (sum term (funcall next a) next b))))
(defun simpson (f a b n)
  (let ((h (/ (- b a) n)))
    (labels ((term (x)
	       (let ((each (funcall f (+ a (* x h)))))
		 (cond
		   ((or (zerop x) (= x n)) each)
		   ((evenp x) (* 2 each))
		   (t (* 4 each))))))
      (* (/ h 3) (sum-iter #'term 0 #'1+ n)))))

;;; Ex 1.30
(defun sum-iter (term a next b)
  (labels ((iter (a res)
	     (if (> a b)
		 res
		 (iter (funcall next a)
		       (+ (funcall term a) res)))))
    (iter a 0)))

;;; Ex 1.31
(defun product (term a next b)
  (if (> a b)
      1
      (* (funcall term a)
	 (product term (funcall next a) next b))))

(defun fac (n)
  (product-iter #'(lambda (x) x) 1 #'1+ n))

(defun sicp-pi (n)
  (labels ((term (x)
	     (let ((2x (* 2 x)))
	       (/ (* 2x (+ 2x 2))
		  (expt (+ 2x 1) 2)))))
    (* 4 (product-iter #'term 1.0 #'1+ n))))

(defun product-iter (term a next b)
  (labels ((iter (a res)
	     (if (> a b)
		 res
		 (iter (funcall next a)
		       (* res (funcall term a))))))
    (iter a 1)))

;;; Ex 1.32
(defun acc (combiner null-value term a next b)
  (if (> a b)
      null-value
      (funcall combiner (funcall term a)
	       (acc combiner null-value
		    term (funcall next a) next b))))

(defun sum-acc (term a next b)
  (acc #'+ 0 term a next b))

(defun product-acc (term a next b)
  (acc-iter #'* 1 term a next b))

(defun acc-iter (combiner null-value term a next b)
  (labels ((iter (a res)
	     (if (> a b)
		 res
		 (iter (funcall next a)
		       (funcall combiner res (funcall term a))))))
    (iter a null-value)))

;;; Ex 1.33
(defun filter-accumulate (combiner null-value term a next b p)
  (if (> a b)
      null-value
      (let ((term-a (funcall term a)))
	(if (funcall p term-a)
	    (funcall combiner term-a
		     (filter-accumulate combiner
					null-value
					term
					(funcall next a)
					next
					b
					p))
	    (filter-accumulate combiner
			       null-value
			       term
			       (funcall next a)
			       next
			       b
			       p)))))

(defun sum-prime (a b)
  (filter-accumulate #'+ 0 (lambda (x) x) a #'1+ b #'prime-p))

(defun sum-coprime (n)
  (filter-accumulate #'* 1 (lambda (x) x) 1 #'1+ (1- n)
		     (lambda (x) (= 1 (gcd x n)))))

;;; Ex 1.34
;; (defun f (g)
;;   (g 2))
;; (f f)
;; (f 2)
;; (2 2) -> error

;;; Ex 1.35
(defun fixed-point (f first-guess)
  (labels ((close-enough-p (v1 v2)
	     (< (abs (- v1 v2)) 0.00001))
	   (try (guess)
	     (print guess)
	     (let ((next (funcall f guess)))
	       (if (close-enough-p guess next)
		   next
		   (try next)))))
    (try first-guess)))

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)
;; 1.1 
;; 72.476555 
;; 1.6127319 
;; 14.4535 
;; 2.586267 
;; 7.2696724 
;; 3.4822383 
;; 5.536501 
;; 4.0364065 
;; 4.9505367 
;; 4.3187075 
;; 4.721779 
;; 4.4503407 
;; 4.6268215 
;; 4.509361 
;; 4.58635 
;; 4.5353723 
;; 4.5689015 
;; 4.546751 
;; 4.5613422 
;; 4.551712 
;; 4.55806 
;; 4.553872 
;; 4.5566335 
;; 4.554812 
;; 4.556013 
;; 4.555221 
;; 4.555743 
;; 4.555399 
;; 4.555626 
;; 4.555476 
;; 4.555575 
;; 4.55551 
;; 4.5555525 
;; 4.555525 
;; 4.555543 
;; 4.555531 
;; 4.5555387

(defun average (a b)
  (/ (+ a b) 2))

(fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 1.1)
;; 1.1 
;; 36.788277 
;; 19.35217 
;; 10.841831 
;; 6.8700476 
;; 5.227225 
;; 4.7019606 
;; 4.582197 
;; 4.560134 
;; 4.55632 
;; 4.5556693 
;; 4.555558 
;; 4.555539 
;; 4.5555363

;;; Ex 1.36
(fixed-point (lambda (x) (/ (log 1000) (log x))) 1.1)

;;; Ex 1.37
(defun cont-frac (f1 f2 k)
  (labels ((frac (i)
	     (let ((n (funcall f1 i))
		   (d (funcall f2 i)))
	       (if (= i k)
		   (/ n d)
		   (/ n (+ d (frac (1+ i))))))))
    (frac 1.0)))

(defun cont-frac-iter (f1 f2 k)
  (labels ((iter (i res)
	     (if (= i 0)
		 res
		 (iter (1- i)
		       (/ (funcall f1 i)
			  (+ (funcall f2 i) res))))))
    (iter (1- k) (/ (funcall f1 k) (funcall f2 k)))))

;;; Ex 1.38
(+ 2 (cont-frac (lambda (i) 1.0)
		(lambda (i)
		  (if (= 2 (mod i 3))
		      (/ (1+ i) 1.5)
		      1))
		100))

;;; Ex 1.39
(defun tan-cf (x k)
  (cont-frac-iter (lambda (i) (if (= i 1) x (* -1 x x)))
		  (lambda (i) (- (* 2.0 i) 1))
		  k))

;;; Ex 1.40
(defparameter dx 0.00001)

(defun newtons-method (g guess)
  (fixed-point (newtons-transform g) guess))

(defun newton-transform (g)
  (lambda (x)
    (- x (/ (funcall g x) (d g) x))))

(defun d (g)
  (lambda (x)
    (/ (- (funcall g (+ x dx)) (funcall g x))
       dx)))

(defun cubic (a b c)
  (lambda (x)
    (+ (* x x x) (* a x x) (* b x) c)))

;;; Ex 1.41
(defun repeat-2 (f) ;double
  (lambda (x) (funcall f (funcall f x))))

;; fucking syntax
;; (funcall (funcall (repeat-2 (repeat-2 #'repeat-2)) #'1+) 5)
;; ->
;; 21
;; (repeat-2 #'repeat-2) 将repeat-2过程应用4次
;; 再(repeat-2 (repeat-2 #'repeat-2)) 将repeat-2过程应用8次
;; repeat-2讲1+应用2次
;; 所以一共16次1+ 

;;; Ex 1.42
(defun compose (f g)
  (lambda (x) (funcall f (funcall g x))))

;;; Ex 1.43
(defun repeated (f n)
  (if (= n 1)
      (lambda (x) (funcall f x))
      (repeated (compose f (lambda (x) (funcall f x))) (1- n))))

;;; Ex 1.44
(defun smooth (f)
  (lambda (x)
    (/ (+ (funcall f x)
	  (funcall f (+ x dx))
	  (funcall f (- x dx)))
       3)))

;;; Ex 1.45
(defun average-damp (f)
  (lambda (x) (average x (funcall f x))))

(defun repeated-average-damp (f n)
  (funcall (repeated #'average-damp n) f))

(defun root (n m)
  (lambda (x)
    (fixed-point (repeated-average-damp
		  (lambda (y) (/ x (expt y (1- n))))
		  m)
		 1.0)))

;;; Ex 1.46
(defun iterative-improve (f g)
  (lambda (x)
    (let ((next (funcall g x)))
      (if (funcall f x next)
	  next
	  (funcall (iterative-improve f g) (funcall g x))))))

(defun sqrt-iteractive-improve (x)
  (funcall (iterative-improve #'good-enough-p
			      #'improve)
	   1.0))

(defun fixed-point-iterative-improve (f first-guess)
  (labels ((close-enough-p (v1 v2)
	     (< (abs (- v1 v2)) 0.00001)))
    (funcall (iterative-improve f #'close-enough-p) first-guess)))
