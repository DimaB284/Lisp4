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
[1]> (defun swap-adjacent (list)
  (cond
    ((null list) nil)
    ((null (cdr list)) list)
    ((> (car list) (cadr list))       
      (cons (cadr list) (cons (car list) (swap-adjacent (cddr list)))))
    (t
     (cons (car list) (swap-adjacent (cdr list))))))
SWAP-ADJACENT

[2]> (defun bubble-sort-functional (list)
  (let ((swapped-list (swap-adjacent list)))
    (if (equal swapped-list list)         
      (bubble-sort-functional swapped-list))))
BUBBLE-SORT-FUNCTIONAL
```

## Тестові набори
```lisp
[3]> (defun run-bubble-sort-functional-tests ()
  (format t "Test 1: bubble-sort-functional ~%")
  (format t "~a~%" (equal (bubble-sort-functional '(4 2 5 1 3)) '(1 2 3 4 5)))
  (format t "Test 2: bubble-sort-functional ~%")
  (format t "~a~%" (equal (bubble-sort-functional '(1 2 3 4 5)) '(1 2 3 4 5)))
  (format t "Test 3: bubble-sort-functional (empty list) ~%")
  (format t "~a~%" (equal (bubble-sort-functional '()) '())))
RUN-REMOVE-SECONDS-AND-THIRDS-TESTS
```

## Тестування функціонального варіанту

```lisp
[4]> (run-bubble-sort-functional-tests)
Test 1: remove-seconds-and-thirds
T
Test 2: remove-seconds-and-thirds
T
Test 3: remove-seconds-and-thirds (empty list)
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
[6]> (defun run-bubble-sort-imperative-tests ()
  (format t "Test 1: bubble-sort-imperative ~%")
  (format t "~a~%" (equal (bubble-sort-imperative '(4 2 5 1 3)) '(1 2 3 4 5)))
  (format t "Test 2: bubble-sort-imperative ~%")
  (format t "~a~%" (equal (bubble-sort-imperative '(1 2 3 4 5)) '(1 2 3 4 5)))
  (format t "Test 3: bubble-sort-imperative (empty list) ~%")
  (format t "~a~%" (equal (bubble-sort-imperative '()) '())))
RUN-LIST-SET-INTERSECTION-TESTS
```

## Тестування імперативного варіанту

```lisp
[7]> (run-bubble-sort-imperative-tests)
Test 1: bubble-sort-imperative
T
Test 2: bubble-sort-imperative
T
Test 3: bubble-sort-imperative (empty list)
T
NIL
```


