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
(defun deep-reverse (lst)
  (let ((acc nil))
    (dolist (obj lst acc)
      (if (consp obj)
	  (push (deep-reverse obj) acc)
	  (push obj acc)))))

;;; Ex 2.28
(defun fringe (lst)
  (cond
    ((null lst) nil)
    ((consp (car lst))
     (append (fringe (car lst)) (fringe (cdr lst))))
    (t
     (cons (car lst) (fringe (cdr lst))))))

;;; Ex 2.29
(defun make-mobile (left right)
  (list left right))

(defun make-branch (len struct)
  (list len struct))

(defun left-branch (m)
  (first m))

(defun right-branch (m)
  (second m))

(defun branch-length (b)
  (first b))

(defun branch-structure (b)
  (second b))

(defun total-weight (m)
  (let* ((lft (left-branch m))
	 (rht (right-branch m))
	 (lfts (branch-structure lft))
	 (rhts (branch-structure rht)))
    (cond
      ((and (atom lfts) (atom rhts))
       (+ lfts rhts))
      ((atom lfts)
       (+ lfts (total-weight rhts)))
      ((atom rhts)
       (+ (total-weight lfts) rhts))
      (t
       (+ (total-weight lfts) (total-weight rhts))))))

(defun moment (b)
  (if (atom (branch-structure b))
      (* (branch-length b) (branch-structure b))
      (* (branch-length b) (total-weight (branch-structure b)))))

(defun balancep (m)
  (if (atom m)
      t
      (let ((lft (left-branch m))
	    (rht (right-branch m)))
	(and (balancep (branch-structure lft))
	     (balancep (branch-structure rht))
	     (= (moment lft) (moment rht))))))

;; (defun make-mobile (lft rht)
;;   (cons lft rht))
;; (defun make-branch (len struct)
;;   (cons len struct))
;; 修改之后只需改下面两个函数
;; (defun right-branch (m)
;;   (cdr m))
;; (defun branch-structure (b)
;;   (cdr b))

;;; Ex 2.30
(defun square-tree (lst)
  (cond
    ((null lst) nil)
    ((atom (car lst))
     (cons (sq (car lst)) (square-tree (cdr lst))))
    (t
     (cons (square-tree (car lst))
	   (square-tree (cdr lst))))))

(defun square-tree-map (lst)
  (mapcar
   #'(lambda (x)
       (if (atom x)
	   (sq x)
	   (square-tree-map x)))
   lst))

;;; Ex 2.31
(defun tree-map (f tree)
  (cond
    ((null tree) nil)
    ((atom (car tree))
     (cons (funcall f (car tree)) (tree-map f (cdr tree))))
    (t
     (cons (tree-map f (car tree))
	   (tree-map f (cdr tree))))))

;;; Ex 2.32
(defun subsets (s)
  (if (null s)
      (list nil)
      (let ((rest (subsets (cdr s))))
	(append rest (mapcar #'(lambda (x)
				 (cons (car s) x))
			     rest)))))


;;; Ex 2.33
(defun accumulate (op init seq)
  (if (null seq)
      init
      (funcall op (car seq)
	       (accumulate op init (cdr seq)))))

(defun map-acc (p seq)
  (accumulate #'(lambda (a b) (cons (funcall p a) b))
	      nil
	      seq))

(defun append-acc (s1 s2)
  (accumulate #'cons
	      s2 s1))

(defun length-acc (seq)
  (accumulate #'(lambda (a b)
		  (declare (ignore a))
		  (+ 1 b))
	      0
	      seq))

;;; Ex 2.34
(defun horner-eval (x coefficient-sequenece)
  (accumulate #'(lambda (this-coeff higher-terms)
		  (+ this-coeff (* x higher-terms)))
	      0
	      coefficient-sequenece))

;;; Ex 2.35
(defun enum (tree)
  (cond
    ((null tree) nil)
    ((atom tree) (list tree))
    (t
     (append (enum (car tree)) (enum (cdr tree))))))
(defun count-leaves (tree)
  (accumulate
   #'(lambda (a b)
       (+ (length a) b))
   0
   (mapcar #'enum tree)))

;;; Ex 2.36
(defun accumulate-n (op init seqs)
  (if (null (car seqs))
      nil
      (cons (accumulate op init (mapcar #'car seqs))
	    (accumulate-n op init (mapcar #'cdr seqs)))))

;;; Ex 2.37
(defvar mat '((1 2 3 4) (4 5 6 6) (6 7 8 9)))
(defvar mat2 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
(defvar vc '(10 10 10 10))

(defun dot-product (v w)
  (accumulate #'+ 0 (mapcar #'* v w)))

(defun matrix-*-vector (m v)
  (mapcar #'(lambda (x) (dot-product x v))
	  m))

(defun transpose (mat)
  (accumulate-n
   #'cons
   nil
   mat))

(defun matrix-*-matrix (m n)
  (let ((cols (transpose n)))
    (mapcar #'(lambda (x)
		(mapcar #'(lambda (y) (dot-product x y)) cols))
	    m)))

;;; Ex 2.38
(defun fold-left (op initial sequence)
  (labels ((iter (result rest)
	     (if (null rest)
		 result
		 (iter (funcall op result (car rest))
		       (cdr rest)))))
    (iter initial sequence)))

;; (accumulate #'/ 1 (list 1 2 3)) -> 3/2
;; (fold-left #'/ 1 (list 1 2 3)) -> 1/6
;; (accumulate #'list nil (list 1 2 3)) -> '(1 (2 (3 nil)))
;; (fold-left #'list nil (list 1 2 3)) -> '(((nil 1) 2) 3)

;;; Ex 2.39
(defun reverse-right (sequence)
  (accumulate #'(lambda (x y) (append y (list x)))
	      nil
	      sequence))

(defun reverse-left (sequence)
  (fold-left #'(lambda (x y) (cons y x))
	     nil
	     sequence))

;;; Ex 2.40
(defun enum-interval (low high)
  (unless (> low high)
    (cons low (enum-interval (1+ low) high))))

(defun flatmap (f seq)
  (accumulate #'append nil (mapcar f seq)))

(defun unique-pairs (n)
  (flatmap #'(lambda (i)
	       (mapcar #'(lambda (j) (list j i))
		       (enum-interval 1 (1- i))))
	   (enum-interval 1 n)))

(defun prime-p (n)
  (if (< n 2)
      nil
      (dotimes (i (1+ (floor (sqrt n))) t)
	(when (and (> i 1)
		   (zerop (mod n i)))
	  (return nil)))))

(defun prime-sum-pairs (n)
  (mapcar #'(lambda (x)
	      (list (car x) (cadr x) (apply #'+ x)))
	  (remove-if-not #'(lambda (x) (prime-p (apply #'+ x)))
			 (unique-pairs n))))

;;; 2.41
(defun triples (n)
  (remove-if-not
   #'(lambda (x)
       (equal (apply #'+ x) n))
   (flatmap
    #'(lambda (i)
	(flatmap
	 #'(lambda (j)
	     (mapcar #'(lambda (k) (list k j i))
		     (enum-interval 1 (1- j))))
	 (enum-interval 1 (1- i))))
    (enum-interval 1 n))))

;;; 2.42
(defparameter empty-board '())

(defun queen (size)
  (labels ((queen-cols (k)
	     (if (zerop k)
		 (list empty-board)
		 (remove-if-not
		  #'(lambda (pos) (safep k pos))
		  (flatmap
		   #'(lambda (rest-of-queens)
		       (mapcar #'(lambda (new-row)
				   (adjion-position new-row
						    k
						    rest-of-queens))
			       (enum-interval 1 size)))
		   (queen-cols (1- k)))))))
    (queen-cols size)))

(defun adjion-position (row col positions)
  (declare (ignore col))
  (cons row positions))

(defun check (r r+1 r-1 rest)
  (cond
    ((null rest) t)
    ((or (eql r (car rest))
	 (eql r+1 (car rest))
	 (eql r-1 (car rest)))
     nil)
    (t
     (check r (1+ r+1) (1- r-1) (cdr rest)))))

(defun safep (k positions)
  (declare (ignore k))
  (let ((r (car positions))
	(rest (cdr positions)))
    (if (null rest)
	t
	(check r (1+ r) (1- r) rest))))

;;; Ex 2.43
(defun queen-wrong (size)
  (labels ((queen-cols (k)
	     (if (zerop k)
		 (list empty-board)
		 (remove-if-not
		  #'(lambda (pos) (safep k pos))
		  (flatmap
		   #'(lambda (new-row)
		       (mapcar #'(lambda (rest-of-queens)
				   (adjion-position new-row
						    k
						    rest-of-queens))
			       (queen-cols (1- k))))
		   (enum-interval 1 size))))))
    (queen-cols size)))

;; 本机测试
;; (time (queen 8))
;; (QUEEN 8)
;; took 4 milliseconds (0.004 seconds) to run.
;; During that period, and with 8 available CPU cores,
;;      4 milliseconds (0.004 seconds) were spent in user mode
;;      1 milliseconds (0.001 seconds) were spent in system mode
;;  630,240 bytes of memory allocated

;; (time (queen-wrong 8))
;; (QUEEN-WRONG 8)
;; took 12,873 milliseconds (12.873 seconds) to run.
;;       1,498 milliseconds ( 1.498 seconds, 11.64%) of which was spent in GC.
;; During that period, and with 8 available CPU cores,
;;      11,332 milliseconds (11.332 seconds) were spent in user mode
;;       1,925 milliseconds ( 1.925 seconds) were spent in system mode
;;  3,066,512,887 bytes of memory allocated.
;;  5,484 minor page faults, 50 major page faults, 0 swaps.

;; 时间T的证明
;;TODO:

;;; Ex 2.44
;; (define (up-split painter n)
;;     (if (= n 0)
;; 	painter
;; 	(let ((smaller (up-split (- n 1))))
;; 	  (below painter (beside smaller smaller)))))

;;; Ex 2.45
;; (define (split f g)
;;     (lambda (painter n)
;;       (if (= n 0)
;; 	  painter
;; 	  (let ((smaller ((split f g) painter (- n 1))))
;; 	    (f painter (g smaller smaller))))))

;;; Ex 2.46
;; (define (make-vect x y)
;;     (cons x y))

;; (define xcor-vect car)
;; (define ycor-vect cdr)

;; (define (add-vect v1 v2)
;;     (make-vect (+ (xcor-vect v1)
;; 		  (xcor-vect v2))
;; 	       (+ (ycor-vect v1)
;; 		  (ycor-vect v2))))

;; (define (sub-vect v1 v2)
;;     (make-vect (- (xcor-vect v1)
;; 		  (xcor-vect v2))
;; 	       (- (ycor-vect v1)
;; 		  (ycor-vect v2))))

;; (define (scale-vect s v)
;;     (make-vect (* s (xcor-vect v))
;; 	       (* s (ycor-vect v))))

;;; Ex 2.47
;; (define (make-frame origin edge1 edge2)
;;     (list origin edge1 edge2))

;; (define (origin-frame frame)
;;     (car frame))
;; (define (edge1-frame frame)
;;     (cadr frame))
;; (define (edge2-frame frame)
;;     (caddr frame))

;; (define (make-frame origin edge1 edge2)
;;     (cons origin (cons edge1 edge2)))

;; (define (origin-frame frame)
;;     (car frame))
;; (define (edge1-frame frame)
;;     (cadr frame))
;; (define (edge2-frame frame)
;;     (cddr frame))

;;; Ex 2.48
;; (define make-segment cons)
;; (define start-segment car)
;; (define end-segment cdr)

;;; Ex 2.49
;; a.
;; (segments->painter '(((0 . 0) 1 . 0)
;; 		     ((1 . 0) 1 . 1)
;; 		     ((1 . 1) 0 . 1)
;; 		     ((0 . 1) 0 . 0)))
;; b.
;; (segments->painter '(((0 . 0) 1 . 1)
;; 		     ((1 . 0) 0 . 1)))
;; c.
;; (segments->painter '(((0.5 . 0) 1 . 0.5)
;; 		     ((1 . 0.5) 0.5 . 1)
;; 		     ((0.5 . 1) 0 . 0.5)
;; 		     ((0 . 0.5) 0.5 . 0)))
;; d.
;; fuck my mind
;; TODO:

;;; Ex 2.50
;; 原框架
;;    3 -- 2
;;     |  |
;;    0 __ 1
;; 只需要变换 origin 0 corner1 1 corner2 3 的位置即可

;;    2 -- 3
;;     |  |
;;    1 __ 0
;; (define (flip-horiz painter)
;;     (transform-painter painter
;; 		       (make-vect 1 0)
;; 		       (make-vect 0 0)
;; 		       (make-vect 1 1)))

;;    1 -- 0
;;     |  |
;;    2 __ 3
;; (define (rotate180 painter)
;;     (transform-painter painter
;; 		       (make-vect 1 1)
;; 		       (make-vect 0 1)
;; 		       (make-vect 1 0)))

;;    0 -- 3
;;     |  |
;;    1 __ 2
;; (define (rotate270 painter)
;;     (transform-painter painter
;; 		       (make-vect 0 1)
;; 		       (make-vect 0 0)
;; 		       (make-vect 1 1)))

;;; Ex 2.51
;; (define (below painter1 painter2)
;;     (let ((split-point (make-vect 0.0 0.5)))
;;       (let ((paint-bottom
;; 	     (transform-painter
;; 	      painter1
;; 	      (make-vect 0.0 0.0)
;; 	      (make-vect 1.0 0.0)
;; 	      split-point))
;; 	    (paint-top
;; 	     (transform-painter
;; 	      painter2
;; 	      split-point
;; 	      (make-vect 1.0 0.5)
;; 	      (make-vect 0.0 1.0))))
;; 	(lambda (frame)
;; 	  (paint-top frame)
;; 	  (paint-bottom frame)))))

;; (define (below painter1 painter2)
;;     (rotate90 (beside (rotate270 painter1)
;;                       (rotate270 painter2))))

;;; Ex 2.52
;; a.
;;TODO:

;; b.
;; (define (corner-split painter n) 
;;     (if (= n 0) 
;; 	painter 
;; 	(beside (below painter (up-split painter (- n 1))) 
;; 		(below (right-split painter (- n 1))
;; 		       (corner-split painter (- n 1))))))

;; c.
;; (define (square-limit painter n) 
;;     (let ((combine4 (square-of-four flip-vert rotate180 
;; 				    identity flip-horiz))) 
;;       (combine4 (corner-split painter n)))) 

;;; Ex 2.53
;; (list 'a 'b 'c) -> '(a b c)
;; (list (list 'george)) -> '((george))
;; (cdr '((x1 x2) (y1 y2))) -> '((y1 y2))
;; (cadr '((x1 x2) (y1 y2))) -> '(y1 y2)
;; (consp (car '(a short list))) -> nil
;; (member 'red '((red shoes) (blue socks))) -> nil
;; (member 'red '(red shoes blue socks)) -> '(red shoes blue socks)

;;; Ex 2.54
(defun equal? (lst1 lst2)
  (cond
    ((and (null lst1) (null lst2)) t)
    ((and (consp (car lst1)) (consp (car lst2)))
     (and (equal? (car lst1) (car lst2))
	  (equal? (cdr lst1) (cdr lst2))))
    ((and (atom (car lst1)) (atom (car lst2)))
     (and (eq (car lst1) (car lst2))
	  (equal? (cdr lst1) (cdr lst2))))
    (t nil)))


;;; Ex 2.55
;; (car ''abracadabra) = (car '(quote abracadabra))

;;; Ex 2.56
(defun deriv (expr var)
  (cond
    ((numberp expr) 0)
    ((symbolp expr) (if (eql expr var) 1 0))
    ((sum-p expr) (make-sum (deriv (a1 expr) var)
			    (deriv (a2 expr) var)))
    ((product-p expr)
     (make-sum (make-product (deriv (m1 expr) var)
			     (m2 expr))
	       (make-product (m1 expr)
			     (deriv (m2 expr) var))))
    ((exponentiation-p expr)
     (make-product (power expr)
		   (make-exponentiation (base expr)
					(1- (power expr)))))
    (t
     (error "Unknown Type."))))

(defun exponentiation-p (expr)
  (and (consp expr) (eql '** (car expr))))

(defun make-exponentiation (a b)
  (cond
    ((number= a 0) 0)
    ((number= b 0) 1)
    ((number= b 1) a)
    ((and (numberp a) (numberp b)) (expt a b))
    (t
     (list '** a b))))

(defun base (expr)
  (second expr))

(defun power (expr)
  (third expr))

(defun sum-p (expr)
  (and (consp expr) (eql '+ (car expr))))

(defun number= (a b)
  (and (numberp a) (= a b)))

(defun product-p (expr)
  (and (consp expr) (eql '* (car expr))))

(defun make-product (a b)
  (cond
    ((or (number= a 0) (number= b 0)) 0)
    ((number= a 1) b)
    ((number= b 1) a)
    ((and (numberp a) (numberp b)) (* a b))
    (t
     (list '* a b))))

(defun make-sum (a b)
  (cond
    ((number= a 0) b)
    ((number= b 0) a)
    ((and (numberp a) (numberp b)) (+ a b))
    (t
     (list '+ a b))))

;;; Ex 2.57
(defun a1 (expr)
  (second expr))

(defun a2 (expr)
  (let ((rest (cddr expr)))
    (if (> (length rest) 1)
	(cons '+ rest)
	(car rest))))

(defun m1 (expr)
  (second expr))

(defun m2 (expr)
  (let ((rest (cddr expr)))
    (if (> (length rest) 1)
	(cons '* rest)
	(car rest))))

;;; Ex 2.58
;; 问题b需要+特殊处理, 如果表达式存在+,通过+分解表达式
;; *不做特殊处理
;; 如果还有**,则需要再通过*分解表达式
;; 总结, 按优先级顺序,从低到高不断的分解表达式
(defun infix-make-sum (a b)
  (cond
    ((number= a 0) b)
    ((number= b 0) a)
    ((and (numberp a) (numberp b)) (+ a b))
    (t
     (list a '+ b))))

(defun infix-make-product (a b)
  (cond
    ((or (number= a 0) (number= b 0)) 0)
    ((number= a 1) b)
    ((number= b 1) a)
    ((and (numberp a) (numberp b)) (* a b))
    (t
     (list a '* b))))

(defun infix-deriv (expr var)
  (cond
    ((numberp expr) 0)
    ((symbolp expr) (if (eql expr var) 1 0))
    ((infix-sum-p expr) (infix-make-sum (infix-deriv (infix-a1 expr) var)
					(infix-deriv (infix-a2 expr) var)))
    ((infix-product-p expr)
     (infix-make-sum (infix-make-product (infix-deriv (infix-m1 expr) var)
					 (infix-m2 expr))
		     (infix-make-product (infix-m1 expr)
					 (infix-deriv (infix-m2 expr) var))))
    (t
     (error "Unknown Type."))))

(defun infix-m1 (expr)
  (first expr))

(defun infix-m2 (expr)
  (let ((rest (cddr expr)))
    (if (> (length rest) 1)
	rest
	(car rest))))

(defun find-until-symbol (expr sym)
  (if (or (null expr) (eql sym (car expr)))
      nil
      (cons (car expr) (find-until-symbol (cdr expr) sym))))

(defun infix-a1 (expr)
  (let ((a1 (find-until-symbol expr '+)))
    (if (> (length a1) 1)
	a1
	(car a1))))

(defun infix-a2 (expr)
  (let ((rest (cdr (member '+ expr))))
    (if (> (length rest) 1)
	rest
	(car rest))))

(defun prior (expr)
  (if (member '+ expr)
      '+
      '*))

(defun infix-sum-p (expr)
  (eql '+ (prior expr)))


(defun infix-product-p (expr)
  (eql '* (prior expr)))

