<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Функціональний і імперативний підходи до роботи зі списками"<br/>
</p>
<p align="right">**Студент**: *Бойко Дмитро Павлович КВ-11*<p>
<p align="right">**Рік**: *2024*<p>

## Загальне завдання

  Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і імперативно. 

    1. Функціональний варіант реалізації має базуватись на використанні рекурсії і конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного списку. Не допускається використання: деструктивних операцій, циклів, функцій вищого порядку або функцій для роботи зі списками/послідовностями, що використовуються як функції вищого порядку. Також реалізована функція не має бути функціоналом (тобто приймати на вхід функції в якості аргументів). 

    2. Імперативний варіант реалізації має базуватись на використанні циклів і деструктивних функцій (псевдофункцій). Не допускається використання функцій вищого порядку або функцій для роботи зі списками/послідовностями, що використовуються як функції вищого порядку. Тим не менш, оригінальний список цей варіант реалізації також не має змінювати, тому перед виконанням деструктивних змін варто застосувати функцію  copy-list	 (в разі необхідності). Також реалізована функція не має бути функціоналом (тобто приймати на вхід функції в якості аргументів).

  Алгоритм, який необхідно реалізувати, задається варіантом (п. 3.1.1). Зміст і шаблон звіту наведені в п. 3.2. 
    
  Кожна реалізована функція має бути протестована для різних тестових наборів. Тести мають бути оформленні у вигляді модульних тестів (наприклад, як наведено в п. 2.3). 


## Варіант 2

  Алгоритм сортування обміном №1 (без оптимізацій) за незменшенням.

## Функціональний варіант
```lisp
;1-st task
[1]> (defun swap-adjacent (list &key (key #'identity) (test #'<))
  (cond
    ((null (cdr list)) list)
    ((funcall test (funcall key (car list)) (funcall key (cadr list)))
     (cons (car list) (swap-adjacent (cdr list) :key key :test test)))
    (t
     (cons (cadr list) (swap-adjacent (cons (car list) (cddr list))
                                      :key key :test test)))))
SWAP-ADJACENT

[2]> (defun bubble-sort-functional (list &key (key #'identity) (test #'<))
    (let ((swapped-list (swap-adjacent list :key key :test test)))
    (if (equal swapped-list list)
        list
      (bubble-sort-functional swapped-list :key key :test test))))
BUBBLE-SORT-FUNCTIONAL
```

## Тестові набори
```lisp
[3]> (defun run-bubble-sort-functional-tests ()
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
RUN-BUBBLE-SORT-FUNCTIONAL-TESTS
```

## Тестування функціонального варіанту

```lisp
[4]> (run-bubble-sort-functional-tests)
Test 1: bubble-sort-functional
T
Test 2: bubble-sort-functional
T
Test 3: bubble-sort-functional
T
Test 4: bubble-sort-functional (empty list)
T
NIL
```

## Імперативний варіант

```lisp
;2-nd task
[5]> (defun add-prev-reducer (&key transform)
  (let ((prev nil))  
    (lambda (acc current)
      (let* ((current-val (if transform (funcall transform current) current))
             (prev-val (if (and transform prev) (funcall transform prev) prev))
             (pair (cons current-val prev-val)))  
        (setf prev current)  
        (nconc acc (list pair))))))
ADD-PREV-REDUCER
```

## Тестові набори
```lisp
[6]> (defun run-add-prev-reducer-tests ()
  (format t "Test 1: add-prev-reducer ~%")
  (format t "~a~%" (equal (reduce (add-prev-reducer)
                         '(1 2 3 4)
                         :from-end nil
                         :initial-value nil)
                 '((1) (2 . 1) (3 . 2) (4 . 3))))
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
RUN-ADD-PREV-REDUCER-TESTS
```

## Тестування імперативного варіанту

```lisp
[7]> (run-add-prev-reducer-tests)
Test 1: add-prev-reducer
T
Test 2: add-prev-reducer
T
Test 3: add-prev-reducer (empty list)
T
NIL
```


