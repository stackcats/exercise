(in-package :sicp)

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

