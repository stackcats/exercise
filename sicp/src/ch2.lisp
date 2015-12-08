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


