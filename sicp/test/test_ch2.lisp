(in-package :sicp-test)

(defun run-test-ch2 ()
  (run-tests))

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
