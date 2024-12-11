<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 4</b><br/>
"Функції вищого порядку та замикання"<br/>
</p>
<p align="right">Студент: Бойко Дмитро Павлович КВ-11<p>
<p align="right">Рік: 2024<p>

## Завдання

 Завдання складається з двох частин: 
 1. Переписати функціональну реалізацію алгоритму сортування з лабораторної роботи №3 з такими змінами:
 - використати функції вищого порядку для роботи з послідовностями (де це доречно);
- додати до інтерфейсу в функції (та використання в реалізації) два ключових параметра: key та test, що працюють аналогічно до того, як працюють параметри з такими назвами в функціях, що працюють з послідовностями. При цьому, key має виконатись мінімальну кількість разів.

 2. Реалізувати функцію, що створює замикання, яке працює згідно із завданням за варіантом (див. п 4.1.2). Використання псевдо-функцій не забороняється, але, за можливості, має бути мінімізоване.


## Варіант 2
 1. Варіант завдання для першої частини обирається той же самий, що і для л.р. №3 (алгоритм сортування обміном №1 (без оптимізацій) за незменшенням).
 2. Варіант завдання для другої частини:
    
 Написати функцію add-prev-reducer , яка має один ключовий параметр — функцію transform. add-prev-reducer має повернути функцію, яка при застосуванні в якості першого аргументу reduce робить наступне: кожен елемент списку-аргументу reduce перетворюється на точкову пару, де в комірці CAR знаходиться значення поточного елемента, а в комірці CDR знаходиться значення попереднього елемента списку (тобто того, що знаходиться "зліва"). Якщо функція transform передана, тоді значення поточного і попереднього елементів, що потраплять у результат, мають бути змінені згідно transform. Обмеження, які накладаються на використання функції-результату add-prev-reducer при передачі у reduce визначаються розробником (тобто, наприклад, необхідно чітко визначити, якими мають бути значення ключових параметрів функції reduce from-end та initial-value ). transform має виконатись мінімальну кількість разів.
 
```lisp
CL-USER> (reduce (add-prev-reducer)

'(1 2 3)
:from-end ...
:initial-value ...)

((1 . NIL) (2 . 1) (3 . 2))
CL-USER> (reduce (add-prev-reducer :transform #'1+)

'(1 2 3)
:from-end ...
:initial-value ...)

((2 . NIL) (3 . 2) (4 . 3))
```


## Перша частина завдання
```lisp
;1-st task
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
```

## Тестування першої частини завдання

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

## Друга частина завдання

```lisp
;2-nd task
(defun add-prev-reducer (&key transform)
  (let* ((transform-fn (or transform #'identity)) 
         (prev nil))  
    (lambda (acc current)
      (let* ((current-val (funcall transform-fn current))
             (prev-val (and prev (funcall transform-fn prev)))  
             (pair (cons current-val prev-val)))  
        (setf prev current)  
        (nconc acc (list pair))))))
```

## Тестові набори
```lisp
[6]> (defun run-add-prev-reducer-tests ()
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
```

## Тестування другої частини завдання

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


