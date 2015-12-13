(in-package :sicp-test)

;;; Ex 2.1
(define-test make-rat
    (assert-equal '(1 . 2) (make-rat 3 6))
  (assert-equal '(-1 . 2) (make-rat -3 6))
  (assert-equal '(-1 . 2) (make-rat 3 -6))
  (assert-error 'error (make-rat 3 0)))

;;; Ex 2.2
(define-test make-point
    (assert-equal '(1 . 1) (make-point 1 1))
  (assert-equal 1 (x-point (make-point 1 2)))
  (assert-equal 2 (y-point (make-point 1 2))))

(define-test make-segment
    (let ((p1 (make-point 1 2))
	  (p2 (make-point 3 4)))
      (assert-equal '((1 . 2) . (3 . 4))
		    (make-segment p1 p2))
      (assert-equal '(1 . 2)
		    (start-segment (make-segment p1 p2)))
      (assert-equal '(3 . 4)
		    (end-segment (make-segment p1 p2)))
      (assert-equal '(2 . 3)
		    (midpoint-segment (make-segment p1 p2)))
      (assert-equal '(0 . 0)
		    (midpoint-segment
		     (make-segment (make-point -3 -5)
				   (make-point 3 5))))))

;;; Ex 2.3
(define-test make-rect-two-ponit
    (let* ((p1 (make-point 5 10))
	   (p2 (make-point 15 5))
	   (rect (make-rect-two-point p1 p2)))
      (assert-equal '(5 . 10) (top-left-rect rect))
      (assert-equal '(15 . 5) (bottom-right-rect rect))
      (assert-equal '(5 . 5) (bottom-left-rect rect))
      (assert-equal '(15 . 10) (top-right-rect rect))
      (assert-equal '((5 . 10) 5 . 5) (left-rect rect))
      (assert-equal '((5 . 10) 15 . 10) (top-rect rect))
      (assert-equal '((5 . 5) 15 . 5) (bottom-rect rect))
      (assert-equal '((15 . 10) 15 . 5) (right-rect rect))
      (assert-equal 50 (area rect))
      (assert-equal 30 (perimeter rect))))

;;; Ex 2.4
(define-test cons-car-cdr
    (assert-equal 1 (car2 (cons2 1 10)))
  (assert-equal 10 (cdr2 (cons2 1 10))))

;;; Ex 2.5
(define-test cons-cons-cons
    (assert-equal 3 (car3 (cons3 3 5)))
  (assert-equal 5 (cdr3 (cons3 3 5))))

;;; Ex 2.7
(define-test make-interval
    (assert-equal 5 (lower-bound (make-interval 10 5)))
  (assert-equal 10 (upper-bound (make-interval 10 5)))
  (assert-equal 5 (lower-bound (make-interval 5 10)))
  (assert-equal 10 (upper-bound (make-interval 5 10))))

;;; Ex 2.8
(define-test sub-interval
    (let* ((x (make-interval 10 20))
	   (y (make-interval 5 30))
	   (z (sub-interval x y)))
      (assert-equal -10 (lower-bound z))
      (assert-equal 5 (upper-bound z))))

;;; Ex 2.9
(define-test interval-width
    (let ((x (make-interval -10 20))
	  (y (make-interval 5 10)))
      (assert-equal 15.0 (width x))
      (assert-equal 2.5 (width y))
      (assert-equal (- (width x) (width y))
      		    (width (sub-interval x y)))
      (assert-equal (+ (width x) (width y))
      		    (width (add-interval x y)))
      (assert-false (equal
      		     (* (width x) (width y))
      		     (width (mul-interval x y))))
      (assert-false (equal
      		     (/ (width x) (width y))
      		     (width (div-interval x y))))))

;;; Ex 2.10
(define-test div-spanning-zero
    (let ((x (make-interval 10 20))
	  (y (make-interval -10 10)))
      (assert-error 'error (div-interval x y))))

;;; Ex 2.11
;;TODO:

;;; Ex 2.12
(define-test make-center-percent
    (let ((c 6.8)
	  (p 10))
      (assert-equal c (center (make-center-percent c p)))
      (assert-equal p (percent (make-center-percent c p)))))

;;; Ex 2.17
(define-test last-pair
    (assert-equal '(34) (last-pair '(23 72 149 34)))
  (assert-equal nil (last-pair '())))

;;; Ex 2.18
(define-test reverse
    (assert-equal '(25 16 9 4 1)
		  (sicp-reverse '(1 4 9 16 25)))
  (assert-equal nil (sicp-reverse nil)))

;;; Ex 2.19
(define-test cc
    (assert-equal 104561 (cc 100 '(100 50 20 10 5 2 1 0.5)))
  (assert-equal 292 (cc 100 '(50 25 10 5 1))))

;;; Ex 2.20
(define-test same-parity
    (assert-equal '(1 3 5 7) (same-parity 1 2 3 4 5 6 7))
  (assert-equal '(2 4 6) (same-parity 2 3 4 5 6 7)))

;;; Ex 2.21
(define-test square-list
    (assert-equal (map-square-list '(1 2 3 4)) '(1 4 9 16))
  (assert-equal (square-list '(1 2 3 4)) '(1 4 9 16)))

;;; Ex 2.22
(define-test square-iter
    (assert-equal (square-iter '(1 2 3 4)) '(1 4 9 16)))

;;; Ex 2.23
(define-test for-each
    (assert-prints "5732188" (for-each (lambda (x) (princ x))
				       '(57 321 88))))

;;; Ex 2.27
(define-test deep-reverse
    (assert-equal (deep-reverse '((1 (5 6 7) 2) (3 4)))
		  '((4 3) (2 (7 6 5) 1))))

;;; Ex 2.28
(define-test fringe
    (let ((x '((1 2) (3 4))))
      (assert-equal '(1 2 3 4) (fringe x))
      (assert-equal '(1 2 3 4 1 2 3 4) (fringe (list x x)))
      (assert-equal nil (fringe nil))))

;;; Ex 2.29
(define-test mobile
    (let* ((m1 (make-mobile (make-branch 10 15)
			    (make-branch 5 10)))
	   (m2 (make-mobile (make-branch 5 5)
			    (make-branch 9 6)))
	   (m3 (make-mobile (make-branch 20 m1)
			    (make-branch 5 m2)))
	   (m4 (make-mobile (make-branch 50 50)
			    (make-branch 8 m3)))
	   (m5 (make-mobile (make-branch 10 5)
			    (make-branch 5 10)))
	   (m6 (make-mobile (make-branch 3 18)
			    (make-branch 9 6)))
	   (m7 (make-mobile (make-branch 80 m5)
			    (make-branch 50 m6))))
      (assert-equal (total-weight m3) 36)
      (assert-equal (total-weight m4) 86)
      (assert-false (balancep m4))
      (assert-true (balancep m7))))

;;; Ex 2.30
(define-test square-tree
    (let ((lst '(1 (2 (3 4) 5) (6 7))))
      (assert-equal '(1 (4 (9 16) 25) (36 49))
		    (square-tree lst))
      (assert-equal '(1 (4 (9 16) 25) (36 49))
		    (square-tree-map lst))))

;;; Ex 2.31
(define-test tree-map
    (let ((lst '(1 (2 (3 4) 5) (6 7))))
      (assert-equal '(1 (4 (9 16) 25) (36 49))
		    (tree-map #'(lambda (x) (* x x)) lst))))

;;; Ex 2.32
(define-test subsets
    (let ((s (subsets '(1 2 3))))
      (assert-equal '(NIL (1) (2) (3) (1 2) (1 3) (2 3) (1 2 3))
		    (sort s #'(lambda (a b)
				(<= (length a) (length b)))))))

;;; Ex 2.33
(define-test accumulate
    (assert-equal '(1 4 9 16 25)
		  (map-acc #'(lambda (x) (* x x))
			   '(1 2 3 4 5)))
  (assert-equal (append '(1 2 3) '(4 5 6))
		(append-acc '(1 2 3) '(4 5 6)))
  (assert-equal 4 (length-acc '(1 2 3 4))))

;;; Ex 2.34
(define-test horner-eval
    (assert-equal (horner-eval 2 '(1 3 0 5 0 1))
		  (+ 1 (* 3 2) (* 5 2 2 2) (* 2 2 2 2 2))))

;;; Ex 2.35
(define-test count-leaves
    (assert-equal 11
		  (count-leaves '(1 (2 (3 4) 6) 7 8 9 (((((1 (2 3))))))))))

;;; Ex 2.36
(define-test accumulate-n
    (assert-equal (accumulate-n #'+
				0
				'((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
		  '(22 26 30)))

;;; Ex 2.37
(define-test matrix
    (let ((m '((1 2 3 4) (4 5 6 6) (6 7 8 9)))
	  (n '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
	  (v '(10 10 10 10)))
      (assert-equal '((70 80 90) (126 147 168) (180 210 240))
		    (matrix-*-matrix m n))
      (assert-equal '((1 4 6) (2 5 7) (3 6 8) (4 6 9))
		    (transpose m))
      (assert-equal '(100 210 300)
		    (matrix-*-vector m v))))

;;; Ex 2.39
(define-test reverse-acc
    (let ((lst '(1 2 3 4 5)))
      (assert-equal (reverse lst)
		    (reverse-left lst))
      (assert-equal (reverse-left lst)
		    (reverse-right lst))))

;;; Ex 2.40
(define-test unique-pairs
    (let ((x '((1 2 3) (2 3 5) (1 4 5) (3 4 7) (2 5 7) (1 6 7) (5 6 11))))
      (assert-equal x (prime-sum-pairs 6))))

(defun sort-helper (a b)
  "Sort a list of list with same length by number."
  (cond
    ((null a) 1)
    ((= (car a) (car b))
     (sort-helper (cdr a) (cdr b)))
    (t
     (< (car a) (car b)))))

;;; Ex 2.41
(define-test triples
    (assert-equal '((1 2 7) (1 3 6) (1 4 5) (2 3 5))
		  (sort (triples 10) #'sort-helper)))


;;; Ex 2.42
(define-test queen
    (assert-equal 92 (length (queen 8))))

;;; Ex 2.54
(define-test equal?
    (assert-true (equal? '(a b (d e (f g)) c)
			 '(a b (d e (f g)) c)))
  (assert-false (equal? '(a b g) '(a b h))))

;;; Ex 2.56
(define-test exponentiation
    (assert-equal '(* 2 x) (deriv '(** x 2) 'x))
  (assert-equal 1 (deriv '(** x 1) 'x))
  (assert-equal '(* 2 x) (deriv '(** x 2) 'x)))

;;; Ex 2.57
(define-test arbitrary-mul-add
    (assert-equal (deriv '(* x y (+ x 3)) 'x)
		  '(+ (* Y (+ X 3)) (* X Y))))

;;; Ex 2.58
(define-test infix-deriv
    (assert-equal 4
		  (infix-deriv '(x + (3 * (x + (y + 2)))) 'x))
  (assert-equal '((y * (x + 3)) + (x * y))
		(infix-deriv '((x * y) * (x + 3)) 'x))
  (assert-equal '((y * (x + 3)) + (x * y))
		(infix-deriv '(x * y * (x + 3)) 'x)))

;;; Ex 2.59
(define-test union-set
    (assert-equal '(1 2 3 4 5 6)
		  (union-set '(1 2 3) '(4 5 6)))
  (assert-equal '(1 2 3)
		(union-set '(1 2 3) '()))
  (assert-equal '(4 5 6)
		(union-set '() '(4 5 6)))
  (assert-equal '(1 2 3 4 5)
		(union-set '(1 2 3) '(3 4 5))))

;;; Ex 2.61
(define-test adjoin-order-set
    (assert-equal '(2 4 6) (adjoin-order-set 2 '(2 4 6)))
  (assert-equal '(1 2 4 6) (adjoin-order-set 1 '(2 4 6)))
  (assert-equal '(2 3 4 6) (adjoin-order-set 3 '(2 4 6)))
  (assert-equal '(2 4 5 6) (adjoin-order-set 5 '(2 4 6)))
  (assert-equal '(2 4 6 7) (adjoin-order-set 7 '(2 4 6))))

;;; Ex 2.62
(define-test union-order-set
    (assert-equal '(1 2 3 4 5 6)
		  (union-order-set '(1 3 5) '(2 4 6)))
  (assert-equal '(1 2 3 4 5)
		(union-order-set '(1 2 3 4) '(2 3 4 5))))

;;; Ex 2.68
(define-test encode
    (assert-equal sample-message
		  (encode (decode sample-message sample-tree)
			  sample-tree)))

;;; Ex 2.69
(define-test generate-huffman-tree
    (assert-equal sample-tree
		  (generate-huffman-tree pairs)))
