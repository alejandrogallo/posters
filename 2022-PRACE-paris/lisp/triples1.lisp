(load "goldstone.lisp")

(save "triples1"
      `(graph "diagram"
              ,(style)
              (:graph '(:ranksep "0.5"))
              (scope "V"
                     (node '(color blue))
                     ,(tensor 2 "vup" "V")
                     ,(tensor 2 "vdown" "V"))
              ,(tensor 2 "tup" "T")
              ,(tensor 2 "tdown" "T")
              (scope "up"
                     ,(particle "vup:0" "tup:1"))
              (scope "down"
                     ,(particle "tdown:1" "vdown:0"))
              (scope "v-v"
                     ,(particle "vdown:1" "vup:1")
                     ,(hole "vdown:1" "vup:1")
                     ,(particle "vdown:0" "vup:0"))
              (scope "t-t"
                     ,(particle "tdown:0" "tup:0")
                     ,(hole "tdown:0" "tup:0")
                     ,(hole "tdown:1" "tup:1"))))
