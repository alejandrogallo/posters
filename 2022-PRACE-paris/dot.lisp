(require :uiop)

(declaim (optimize (debug 3) (safety 3)))
(defun render-sdot (stream graph)
  (eval `(render-sdot-macro ,stream ,graph)))

(defparameter *default-indentation* "  ")
(defun indent (text &key (indentation *default-indentation*))
  (declare (string text) (string indentation))
  (with-output-to-string (s)
    #1=(princ indentation s)
    (mapc (lambda (c) (princ c s) (when (char= c #\newline) #1#))
          (coerce text 'list))))

(defun indent-list (textlist &key (indentation *default-indentation*))
  (indent (format nil "~{~a~^~%~}" textlist) :indentation indentation))

(defmacro render-sdot-macro (stream graph)
  `(labels ((-- (from to &rest opts)
              (format ,stream "~a -- ~a ~a" from to (-[options] opts)))
            (-> (from to &rest opts)
              (apply #'-- (append (list from to) (cons '(dir "forward") opts))))
            (<- (from to &rest opts)
              (apply #'-- (append (list from to) (cons '(dir "back") opts))))
            (-render-atom (p) (if (symbolp p)
                                  (substitute #\_ #\- (string-downcase
                                                       (symbol-name p)))
                                  p))
            (-[options] (opts) (format ,stream "[~{~a~^, ~}]" (-options opts)))
            (-options (opts) (mapcar (lambda (o)
                                       (etypecase o
                                         (atom (format ,stream "~a" o))
                                         (list (:= (car o) (cadr o)))))
                                     opts))
            (scope (name &rest els)
              (format ,stream "~&{ /* begin: ~a */~%~a~%} /* end: ~a */"
                      name (indent-list els) name))
            (:= (key var)
              (format ,stream "~a = ~s" (-render-atom key) (-render-atom var)))
            (el (name &rest opts)
              (format ,stream "~(~a~) ~a" name (-[options] opts)))
            (node (&rest opts) (apply #'el (cons "node" opts)))
            (edge (&rest opts) (apply #'el (cons "edge" opts)))
            (:graph (&rest opts) (apply #'el (cons "graph" opts)))
            (cluster (name &rest els) (format ,stream
                                              "cluster cluster_~a ~a"
                                              name
                                              (apply #'scope (cons "" els))))
            (-named-scope (scope-name name els)
              (format ,stream "~a ~a {~%~a~%}"
                      scope-name name
                      (indent-list (remove-if-not
                                    (lambda (x) (and (atom x)
                                                     (not (functionp x))
                                                     (not (null x)))) els))))
            (graph (name &rest els) (-named-scope "graph" name els))
            (digraph (name &rest els) (-named-scope "digraph" name els)))
     ,graph))

(defun save (file-basename graph &key (format :svg))
  (let ((dot-string (render-sdot nil graph))
        (out-file (format nil "~a.~(~a~)" file-basename format))
        (dot-file (format nil "~a.dot" file-basename))
        (dot-cmd (format nil "dot -T~(~a~)" format)))
    ;; save dot file
    (with-open-file (f dot-file :if-exists :supersede :direction :output)
      (princ dot-string f))
    ;; create export
    (with-input-from-string (i dot-string)
      (with-open-file (f out-file :if-exists :supersede :direction :output)
      (princ (with-output-to-string (o)
               (uiop:run-program dot-cmd :output o :input i))
             f)))
    out-file))



(defun hole (from to)
  `(<- ,from ,to '(:color :red)))
(defun particle (from to)
  `(-> ,from ,to '(:color :black)))

(defun make-top (names &rest opts)
  `(scope "top level"
          (:= :rank :sink)
          (node '(shape point) '(width .01))
          ,@opts
          ,@names))

(save "test"
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
