;1 task

(defun swap-adjacent (list &key (key #'identity) (test #'<))
  (cond
    ((null (cdr list)) list)  
    ((funcall test (funcall key (car list)) (funcall key (cadr list)))
     (cons (car list) (swap-adjacent (cdr list) :key key :test test)))
    (t
     (cons (cadr list) (swap-adjacent (cons (car list) (cddr list))
                                      :key key :test test)))))

(defun bubble-sort-functional (list &key (key #'identity) (test #'<))
    (let ((swapped-list (swap-adjacent list :key key :test test)))
    (if (equal swapped-list list)  
        list
      (bubble-sort-functional swapped-list :key key :test test))))



(defun run-bubble-sort-functional-tests ()
  (format t "Test 1: bubble-sort-functional ~%")
  (format t "~a~%" (equal (bubble-sort-functional '(3 2 1 0))
                 '(0 1 2 3)))
  (format t "Test 2: bubble-sort-functional ~%")
  (format t "~a~%" (equal (bubble-sort-functional '(0 1 2 3) :test #'>)
                 '(3 2 1 0)))
 (format t "Test 3: bubble-sort-functional ~%")
  (format t "~a~%" (equal (bubble-sort-functional '(0 1 2 3) :test #'<)
                 '(0 1 2 3)))
  (format t "Test 4: bubble-sort-functional (empty list) ~%")
  (format t "~a~%" (equal (bubble-sort-functional '()) '())))



(run-bubble-sort-functional-tests)

;2 task

(defun add-prev-reducer (&key transform)
  (let* ((transform-fn (or transform #'identity)) 
         (prev nil))  
    (lambda (acc current)
      (if (and (not (null current)) (not (eq current t))) 
          (let* ((current-val (funcall transform-fn current))
                 (prev-val (and (not (null prev)) (funcall transform-fn prev)))  
                 (pair (cons current-val prev-val)))  
            (setf prev current)
            (nconc acc (list pair)))
        acc))))



(defun run-add-prev-reducer-tests ()
  (format t "Test 1: add-prev-reducer ~%")
  (format t "~a~%" (equal (reduce (add-prev-reducer)
                         '(1 2 3 4)
                         :from-end nil
                         :initial-value nil)
                 '((1 . NIL) (2 . 1) (3 . 2) (4 . 3))))
  (format t "Test 2: add-prev-reducer ~%")
  (format t "~a~%" (equal (reduce (add-prev-reducer :transform (lambda (x) (+ x 1)))
                         '(1 2 3 4)
                         :initial-value nil
                         :from-end nil)
                 '((2 . NIL) (3 . 2) (4 . 3) (5 . 4))))
  (format t "Test 3: add-prev-reducer (empty list) ~%")
   (format t "~a~%" (equal (reduce (add-prev-reducer)
                         '()
                         :initial-value nil
                         :from-end nil)
                 '())))


(run-add-prev-reducer-tests)
