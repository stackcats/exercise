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

(print (cc 11 '(10 5 1)))
