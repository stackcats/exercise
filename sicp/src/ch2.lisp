(in-package :sicp)

;;; Ex 2.1
(defun make-rat (numer denom)
  (if (zerop denom)
      (error "denom is zero not a valid argument to MAT-RAT.")
      (let* ((n (abs numer))
	     (d (abs denom))
	     (sign (/ (* numer denom) (* n d)))
	     (g (gcd n d)))
	(cons (/ (* sign n) g) (/ d g)))))

(defun numer (x)
  (car x))

(defun denom (x)
  (cdr x))


;;; Ex 2.2
(defun make-point (x y)
  (cons x y))

(defun x-point (p)
  (car p))

(defun y-point (p)
  (cdr p))

(defun mid-point (p1 p2)
  (make-point (/ (+ (x-point p1) (x-point p2)) 2)
	      (/ (+ (y-point p1) (y-point p2)) 2)))

(defun make-segment (p1 p2)
  (cons p1 p2))

(defun start-segment (seg)
  (car seg))

(defun end-segment (seg)
  (cdr seg))

(defun midpoint-segment (seg)
  (mid-point (start-segment seg)
	     (end-segment seg)))


;;; Ex 2.3

;;  p1  ------ 
;;     |      |
;;     |      |
;;      ______  p2

(defun make-rect-two-point (p1 p2)
  (cons p1 p2))

(defun top-left-rect (rect)
  (car rect))

(defun bottom-right-rect (rect)
  (cdr rect))

(defun top-right-rect (rect)
  (make-point (x-point (bottom-right-rect rect))
	      (y-point (top-left-rect rect))))

(defun bottom-left-rect (rect)
  (make-point (x-point (top-left-rect rect))
	      (y-point (bottom-right-rect rect))))

(defun left-rect (rect)
  (make-segment (top-left-rect rect)
		(bottom-left-rect rect)))

(defun top-rect (rect)
  (make-segment (top-left-rect rect)
		(top-right-rect rect)))

(defun bottom-rect (rect)
  (make-segment (bottom-left-rect rect)
		(bottom-right-rect rect)))

(defun right-rect (rect)
  (make-segment (top-right-rect rect)
		(bottom-right-rect rect)))

(defun length-segment (seg)
  (let* ((p1 (start-segment seg))
	 (p2 (end-segment seg))
	 (x1 (x-point p1))
	 (x2 (x-point p2))
	 (y1 (y-point p1))
	 (y2 (y-point p2))
	 (x (- x2 x1))
	 (y (- y2 y1)))
    (sqrt (+ (* x x) (* y y)))))


(defun perimeter (rect)
  (*  2 (+ (length-segment (left-rect rect))
	   (length-segment (top-rect rect)))))

(defun area (rect)
  (* (length-segment (left-rect rect))
     (length-segment (top-rect rect))))

;;        top
;;  p1   ------
;;      |      |
;; left |      |
;;      |      |
;;       ------
;; 提供顶点p1和top left两条边
;; 保证left-rect top-rect 接口的一致性即可


;;; Ex 2.4
(defun cons2 (x y)
  #'(lambda (m) (funcall m x y)))

(defun car2 (z)
  (funcall z
	   #'(lambda (x y)
	       (declare (ignore y)) x)))

(defun cdr2 (z)
  (funcall z
	   #'(lambda (x y)
	       (declare (ignore x)) y)))


;;; Ex 2.5

(defun cons3 (x y)
  (* (expt 2 x) (expt 3 y)))

(defun mod-test (x y)
  (if (zerop (mod x y))
      (1+ (mod-test (/ x y) y))
      0))

(defun car3 (z)
  (mod-test z 2))

(defun cdr3 (z)
  (mod-test z 3))


;;; Ex 2.6
#|
(defvar zero nil)
(defvar one nil)
(defvar two nil)

(setq zero (lambda (f) (lambda (x) x)))

(defun add-1 (n)
  (lambda (f)
    (lambda (x) (f ((n f) x)))))

(setq one (lambda (f) (lambda (x) (f x))))

(setq two (lambda (f) (lambda (x) (f (f x)))))

(defun church+ (m n)
  (lambda (f)
    (lambda (x)
      (m (n f x)))))
|#

;;; Ex 2.7
(defun add-interval (x y)
  (make-interval
   (+ (lower-bound x) (lower-bound y))
   (+ (upper-bound x) (upper-bound y))))

(defun mul-interval (x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
	(p2 (* (lower-bound x) (upper-bound y)))
	(p3 (* (upper-bound x) (lower-bound y)))
	(p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))))


(defun make-interval (a b)
  (cons a b))

(defun upper-bound (n)
  (max (car n) (cdr n)))

(defun lower-bound (n)
  (min (car n) (cdr n)))

;;; Ex 2.8
(defun sub-interval (x y)
  (make-interval
   (- (lower-bound x) (lower-bound y))
   (- (upper-bound x) (upper-bound y))))

;;; Ex 2.9
(defun width (n)
  (/ (- (upper-bound n) (lower-bound n)) 2.0))

;;; Ex. 2.10
(defun div-interval (x y)
  (if (>= 0 (* (upper-bound y) (lower-bound y)))
      (error "Div by internal spanning zero make no sense.")
      (mul-interval x
		    (make-interval (/ 1.0 (upper-bound y))
				   (/ 1.0 (lower-bound y))))))

;;; Ex 2.11
;;;TODO: 

;;; Ex 2.12
(defun make-center-percent (a b)
  (let ((p (/ (* a b) 100)))
    (make-interval (- a p) (+ a p))))

(defun center (n)
  (/ (+ (lower-bound n) (upper-bound n)) 2))

(defun percent (n)
  (round (/ (width n) (center n) .01)))

;;; Ex 2.13
;; 两个区间 (c center, p percent)
;; i1 = [c1*(1-0.01*p1), c1*(1+0.01*p1)]   (1)
;; i2 = [c2*(1-0.01*p2), c2*(1+0.01*p2)]   (2)
;; 只考虑正数,带入mul-interval
;; i1*i2 = [c1*c2*(1 - 0.01*(p1+p2) + 0.0001*p1*p2)
;;          ,c1*c2*(1 + 0.01*(p1+p2) + 0.0001*p1*p2)]
;; 当p1,p2足够小的时候可以忽略0.0001*p1*p2
;; i1*i2 = [c1*c2*(1 - 0.01*(p1+p2)) ,c1*c2*(1 + 0.01*(p1+p2))] (3)
;; 通过(3)发现
;; i3 = i1*i2
;;    = [c1*c2*(1 - 0.01*(p1+p2)) ,c1*c2*(1 + 0.01*(p1+p2))]
;;    = [c3*(1-0.01*p3), c3*(1+0.01*p3)]
;; c3 = c1*c2, p3 = p1 + p2
;; 所以当p1,p2足够小的时候 p3 ＝ p1 + p2

;;; Ex 2.14
;; (defvar i1 (make-center-percent 6.8 10))
;; (div-interval i1 i1) -> (0.8181819 . 1.2222222)
;; 浮点数误差

;;; Ex 2.15
;; 浮点数参与计算的次数越少, 结果的误差越小 Eva是对的

;;; Ex 2.16
;; 中间计算过程用有理数代替浮点数的使用
;; 比如计算过程中使用1/3而不是0.3333333
;; 由用户负责将最终结果转换为浮点数, 所有中间过程始终使用有理数计算

;; Ex 2.17
(defun last-pair (lst)
  (cond
    ((null lst) nil)
    ((null (cdr lst)) lst)
    (t
     (last-pair (cdr lst)))))

;;; Ex 2.18
(defun sicp-reverse (lst)
  (if (null lst)
      nil
      (append (sicp-reverse (cdr lst)) (list (car lst)))))

;;; Ex 2.19
(defvar us-coins '(50 25 10 5 1))
(defvar uk-coins '(100 50 20 10 5 2 1 0.5))
(defvar cc-counts 0)

(defun cc (amount coin-values)
  ;;(incf cc-counts) ;测试递归次数
  (cond
    ((= amount 0) 1)
    ((or (< amount 0) (no-more? coin-values)) 0)
    (t
     (+ (cc amount
	    (except-first-denomination coin-values))
	(cc (- amount
	       (first-denomination coin-values))
	    coin-values)))))

(defun first-denomination (lst)
  (car lst))

(defun except-first-denomination (lst)
  (cdr lst))

(defun no-more? (lst)
  (null lst))

;;改变链表顺序不会影响程序结果但会影响程序的运行时间
;;因为降序排列时递归计算的次数要少
;;下面为本机测试结果,明显uk-coins要比(reverse uk-coins)快很多
;; (time (cc 100 uk-coins))
;; (CC 100 UK-COINS)
;; took 597 milliseconds (0.597 seconds) to run.
;;        5 milliseconds (0.005 seconds, 0.84%) of which was spent in GC.
;; During that period, and with 8 available CPU cores,
;;      576 milliseconds (0.576 seconds) were spent in user mode
;;       26 milliseconds (0.026 seconds) were spent in system mode
;;  31,125,744 bytes of memory allocated.
;;  43 minor page faults, 0 major page faults, 0 swaps.
;; 104561

;; (time (cc 100 (reverse uk-coins)))
;; (CC 100 (REVERSE UK-COINS))
;; took 2,673 milliseconds (2.673 seconds) to run.
;;         21 milliseconds (0.021 seconds, 0.79%) of which was spent in GC.
;; During that period, and with 8 available CPU cores,
;;      2,591 milliseconds (2.591 seconds) were spent in user mode
;;        106 milliseconds (0.106 seconds) were spent in system mode
;;  118,946,584 bytes of memory allocated.
;;  7 minor page faults, 0 major page faults, 0 swaps.
;; 104561

;; 使用变量cc-counts记录递归次数
;; (cc 100 uk-coins)
;; cc-counts -> 7990853

;; (cc 100 (reverse uk-coins))
;; cc-counts -> 30482293

;;; Ex 2.20
(defun same-parity (&rest args)
  (if (null args)
      nil
      (let ((m (mod (car args) 2)))
	(remove-if-not #'(lambda (x) (eql m (mod x 2))) args))))

;;; Ex 2.21
(declaim (inline sq))
(defun sq (n)
  (* n n))

(defun square-list (lst)
  (if (null lst)
      nil
      (cons (sq (car lst))
	    (square-list (cdr lst)))))

(defun map-square-list (lst)
  (mapcar #'sq lst))

;;; Ex 2.22
;;(square-list '(1 2 3 4)
;;版本1每次迭代都将(car lst)添加到answer之前所以顺序是反的
;;版本2结果为((((nil . 1) . 2) . 3) . 4),每次迭代都在构造一个cons对

(defun square-iter (lst)
  (labels ((iter (lst acc)
	     (if (null lst)
		 acc
		 (iter (cdr lst)
		       (append acc (list (sq (car lst))))))))
    (iter lst nil)))

;;common lisp常规写法
;; (defun square-iter-cl (lst)
;;   (let ((acc nil))
;;     (dolist (obj lst (nreverse acc))
;;       (push (sq obj) acc))))

;;; Ex 2.23
(defun for-each (f lst)
  (when lst
    (funcall f (car lst))
    (for-each f (cdr lst))))

;;; Ex 2.24
;;'(1 (2 (3 4)))

;;; Ex 2.25
;;(car '(1 3 (5 7) 9) -> 1
;;(cdr '(1 3 (5 7) 9) -> '(3 (5 7) 9)

;;(car '((7))) -> '(7)
;;(cdr '((7))) -> nil

;;(car '(1 (2 (3 (4 (5 (6 7))))))) -> 1
;;(cdr '(1 (2 (3 (4 (5 (6 7))))))) -> '((2 (3 (4 (5 (6 7))))))

;;; Ex 2.26
(defparameter x '(1 2 3))
(defparameter y '(4 5 6))
;;(append x y) -> '(1 2 3 4 5 6)
;;(cons x y) -> '((1 2 3) 4 5 6)
;;(list x y) -> '((1 2 3) (4 5 6))

;;; Ex 2.27
;;TODO: 
