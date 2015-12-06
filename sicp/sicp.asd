(asdf:defsystem :sicp
  :description "SICP exercise"
  :author "stackcats"
  :pathname "src"
  :components ((:file "package")
	       (:file "ch1" :depends-on ("package"))
	       (:file "ch2" :depends-on ("package"))
	       (:file "ch3" :depends-on ("package"))
	       (:file "ch4" :depends-on ("package"))
	       (:file "ch5" :depends-on ("package"))))

(asdf:defsystem :sicp-test
  :description "SICP exercise test"
  :depends-on (:lisp-unit :sicp)
  :pathname "test"
  :components ((:file "package")
	       (:file "test_ch1" :depends-on ("package"))
	       (:file "test_ch2" :depends-on ("package"))
	       (:file "test_ch3" :depends-on ("package"))
	       (:file "test_ch4" :depends-on ("package"))
	       (:file "test_ch5" :depends-on ("package"))))

