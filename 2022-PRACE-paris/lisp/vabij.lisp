(load "goldstone.lisp")

(save "vabij"
      `(graph "Diagram"
              ,(style)
              ,(make-top '(:t1 :t2 :t3 :t4))
              (scope "V"
                     (node '(color blue))
                     ,(tensor 2 :v "V"))
              ,(particle "v:0" :t1)
              ,(hole "v:0" :t2)
              ,(particle "v:1" :t3)
              ,(hole "v:1" :t4)))
