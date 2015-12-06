(in-package :sicp-test)

;;; Ex 2.1
(define-test make-rat
    (assert-equal '(1 . 2) (make-rat 3 6))
  (assert-equal '(-1 . 2) (make-rat -3 6))
  (assert-equal '(-1 . 2) (make-rat 3 -6))
  (assert-error 'error (make-rat 3 0)))

(defun run-test-ch2 ()
  (run-tests))
