(load "goldstone.lisp")

(save "t2-diagram"
      `(graph "Diagram"
              (:graph '(:fontname "CMU Serif")
                      '(:rankdir "BT")
                      '(:splines "line")
                      '(:nodesep "equally"))

              (scope "t2-diagram"
                     ,(make-top '(:top1 :top2 :top3 :top4))
                     (el :t2 '(label "<0>|T|<1>") '(shape "record") '(:height 0.1))

                     ;; legs
                     ,(hole "t2:0" :top1)
                     ,(particle "t2:0" :top2)
                     ,(hole "t2:1" :top3)
                     ,(particle "t2:1" :top4))

              (scope "t1-diagram"
                     ,(make-top '(:top1_1 :top1_2))
                     (el :t1 '(label "T") '(shape "square") '(height 0.0))
                     ,(hole "t1:0" :top1_1)
                     ,(particle "t1:0" :top1_2))

              )
      :format :svg)

