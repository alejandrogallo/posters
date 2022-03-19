(load "goldstone.lisp")

(defparameter *n* 2)
(defparameter *tops*
  (let ((n-legs (* 2 (/ (* *n* (+ *n* 1)) 2))))
    (loop for i below n-legs
          collect `',(gensym "HEAVEN"))))

(defparameter *ts*
  (loop for i below *n*
        collect (tensor (1+ i) (format nil "t~a" (1+ i)) "")))

(defparameter *contractions*
  (loop for ts in *ts*
        with i = 0
        with c = -1
        append (let ((name (cadr ts)))
                 (loop for j below (incf i)
                       appending (list (hole #1=(format nil "~a:~a" name j)
                                             #2=(nth (incf c) *tops*))
                                       (particle #1# #2#))))))



(save "fcc"
      `(graph "Diagram"
              ,(style)
              (scope "tops" ,(make-top *tops*))
              ,@*ts*
              ,@*contractions*
              ))

(reduce (lambda (x y)
          (cons x (when y (cons '+ y))))
        '(1 5 6)
        :initial-value nil
        :from-end t)

