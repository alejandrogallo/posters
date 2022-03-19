(load "goldstone.lisp")

(defparameter *n* 3)
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
        append
        (let ((name (cadr ts)))
          (loop for j below (* 2 (incf i))
                collect (hole (format nil "~a:~a" name j)
                              (nth (- (+ (* 2 i) j) 1) *tops*))))))


(save "fcc"
      `(graph "Diagram"
              ,(style)
              (scope "tops" ,(make-top *tops*))
              ,@*ts*
              ,@*contractions*
              ))

