(load "goldstone.lisp")

(save "particle"
      `(graph "particle"
              (:graph '(rankdir "RL"))
              (node '(shape none) '(label ""))
              ,(particle :a :b)))
