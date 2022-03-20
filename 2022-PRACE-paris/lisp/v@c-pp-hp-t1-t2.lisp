(load "goldstone.lisp")

(save "v@c-pp-hp-t1-t2"
      `(graph "diagram"
              ,(style)
              ,(make-top '(:top1 :top2 :top3 :top4))
              (scope "V"
                    (node '(color blue))
                    ,(tensor 2 "v" "V"))
              ,(tensor 1 "t1" "T")
              ,(tensor 2 "t2" "T")
              (scope "t1 times v"
                     ,(particle "t1:0" "v:0")
                     ,(particle "v:0" :top1)
                     ,(hole "t1:0" :top2))
              (scope "t2 times V"
                     ,(particle "t2:0" "v:1")
                     ,(hole "t2:0" "v:1")
                     ,(particle "t2:1" :top3)
                     ,(hole "t2:1" :top4))))
