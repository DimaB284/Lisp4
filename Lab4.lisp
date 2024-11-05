;2 task

(defun add-prev-reducer (&key transform)
  (let ((prev nil))  
    (lambda (acc current)
      (let* ((current-val (if transform (funcall transform current) current))
             (prev-val (if (and transform prev) (funcall transform prev) prev))
             (pair (cons current-val prev-val)))  
        (setf prev current)  
        (nconc acc (list pair))))))



(reduce (add-prev-reducer :transform #'1+)
        '(1 2 3)
        :from-end nil
        :initial-value nil)
