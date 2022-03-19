(load "goldstone.lisp")

(save "t3"
      `(graph "Diagram"
              ,(style)
              (scope "top" ,(make-top '(:top1 :top2 :top3 :top4 :top5 :top6)))
              (scope "t3 diagram" ,(tensor 3 :t3 "T"))
              ,(hole "t3:0" :top1)
              ,(particle "t3:0" :top2)
              ,(hole "t3:1" :top3)
              ,(particle "t3:1" :top4)
              ,(hole "t3:2" :top5)
              ,(particle "t3:2" :top6)))
