(load "dot.lisp")

(defmacro with-gensyms (names &body forms)
  `(let ,(mapcar (lambda (name)
                   (multiple-value-bind (symbol string)
                       (etypecase name
                         (symbol
                          (values name (symbol-name name)))
                         ((cons symbol (cons string-designator null))
                          (values (first name) (string (second name)))))
                     `(,symbol (gensym ,string))))
                 names)
     ,@forms))

(defun hole (from to)
  `(<- ,from ,to '(:color :black)))

(defun particle (from to)
  `(-> ,from ,to '(:color :red)))

(defun make-top (names &rest opts)
  `(scope "top level"
          (:= :rank :sink)
          (node '(shape point) '(width .0))
          ,@(mapcar (lambda (x) `',x) opts)
          ,@names))

(defun tensor (order name label &rest opts)
  (let ((-label (case order
                  (1 label)
                  (t (format nil "~{~a~^|~}"
                             (loop for i below order
                                   collect
                                   (format nil "<~a>~a" i
                                           (if (= i (floor order 2))
                                               label ""))))))))
    `(el ,name
         '(label ,-label)
         '(shape "record")
         '(heigth 0.01)
         ,@(mapcar (lambda (x) `',x) opts))))

(defun style ()
  `(:list (:graph '(:fontname "CMU Serif")
                  '(:rankdir "BT")
                  '(:splines "line")
                  '(:nodesep "equally"))
          (node '(:fontname "CMU Serif"))))

(defun plus ()
  `(el (gensym) '(:shape :none) '(label "+")))

(defun t-amplitude (n)
  "Create a stand-alone t-amplitude"
  (let* ((*tops* (loop for i below (* 2 n) collect `',(gensym "HEAVEN")))
         (*t* (tensor n (format nil "t~a" n) ""))
         (*contractions* (let ((name (cadr *t*)))
                           (loop for j below n
                                 with c = -1
                                 appending
                                 (list (hole #1=(format nil "~a:~a" name j)
                                             #2=(nth (incf c) *tops*))
                                       (particle #1# #2#))))))
    `(:list ,(make-top *tops*)
            ,*t*
            ,@*contractions*)))
