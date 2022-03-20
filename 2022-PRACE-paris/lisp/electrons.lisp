(load "goldstone.lisp")

(save "electrons"
      `(graph "electron"
              (:graph '(rankdir "RL"))
              (node '(shape none) '(label ""))
              ,(hole :a :b)))
