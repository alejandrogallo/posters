(load "goldstone.lisp")

(load "goldstone.lisp")

(save "t2"
      `(graph "Diagram"
              ,(style)
              ,(make-top '(:t1 :t2 :t3 :t4))
              ,(tensor 2 :t "T")
              ,(particle "t:0" :t1)
              ,(hole "t:0" :t2)
              ,(particle "t:1" :t3)
              ,(hole "t:1" :t4)))
