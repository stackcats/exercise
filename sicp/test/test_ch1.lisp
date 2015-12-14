(in-package :sicp-test)

(defun run-test ()
  (run-tests))

;;; Ex 1.3
(define-test square-of-larger
    (assert-equal 13 (square-of-larger 1 2 3))
  (assert-equal 13 (square-of-larger 3 2 1))
  (assert-equal 13 (square-of-larger 2 1 3))
  (assert-equal 13 (square-of-larger 3 1 2)))

;;; Ex 1.8
(define-test cube-root
    (assert-equalp 5 (cube-root 125))
  (assert-equalp 123 (cube-root (expt 123 3))))

;;; Ex 1.11
(define-test f-iter-recur
    (assert-equal (f-iter 2) (f-recur 2))
  (assert-equal (f-iter 10) (f-recur 10)))

;;; Ex 1.16
(define-test fast-expt
    (dotimes (i 5)
      (let ((n (random 100)))
	(assert-equal (expt 3 n)
		      (fast-expt 3 n)))))

;;; Ex 1.17
(define-test fast-mul
    (dotimes (i 5)
      (let ((a (random 100))
	    (b (random 100)))
	(assert-equal (* a b) (fast-mul a b)))))

;;; Ex 1.18
(define-test fast-mul-iter
    (dotimes (i 5)
      (let ((a (random 100))
	    (b (random 100)))
	(assert-equal (* a b) (fast-mul-iter a b)))))

;;; Ex 1.19
(define-test fib
    (assert-equal '(1 1 2 3 5 8 13 21 34 55)
		  (mapcar #'fib '(1 2 3 4 5 6 7 8 9 10))))

;;; Ex 1.27
(define-test carmichael-test
    (dolist (obj '(561 1105 1729 2821 6601))
      (assert-true (carmichael-test obj))))

;;; Ex 1.30
(define-test sum-iter
    (dotimes (i 10)
      (let* ((a (random 100))
	     (b (+ a (random 100))))
	(assert-equal (sum #'(lambda (x) x) a #'1+ b)
		      (sum-iter #'(lambda (x) x) a #'1+ b)))))

;;; Ex 1.31
(define-test fac
    (assert-equal (* 1 2 3 4 5 6 7 8 9 10)
		  (fac 10)))

;;; Ex 1.32
(define-test accumulate
    (labels ((f (x) x))
      (assert-equal (sum-acc f 1 #'1+ 10)
		    (sum f 1 #'1+ 10))
      (assert-equal (product-acc f 1 #'1+ 10)
		    (product f 1 #'1+ 10))))

;;; Ex 1.33
(define-test filter-accumulate
    (assert-equal 1060 (sum-prime 1 100))
  (assert-equal 189 (sum-coprime 10)))

;;; Ex 1.37
(define-test cont-frac
    (flet ((f (x) 1.0))
      (dotimes (i 5)
	(let ((k (random 20)))
	  (assert-equal (cont-frac #'f #'f k)
			(cont-frac-iter #'f #'f k))))))

;;; Ex 1.42
(define-test compose
    (assert-equal 49
		  (funcall (compose (lambda (x) (* x x))
				    #'1+)
			   6)))

;;; Ex 1.43
(define-test repeated
    (assert-equal 625
		  (funcall (repeated (lambda (x) (* x x)) 2) 5)))
