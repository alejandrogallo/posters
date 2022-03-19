(load "goldstone.lisp")

(dolist (n '(1 2 3 4 5))
  (print (save (format nil "t-~a" n)
               `(graph "Diagram"
                       ,(style)
                       ,(t-amplitude n)))))
