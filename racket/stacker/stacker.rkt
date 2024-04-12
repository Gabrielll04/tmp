#lang br/quicklang

(define (read-syntax path port)
  (define src-lines (port->lines port))
  (define src-datums (format-datums '(handle ~a) src-lines))
  (define module-datum `(module stacker-mod "stacker.rkt"
                          ,@src-datums))
  (datum->syntax #f module-datum))
(provide read-syntax)

; syntax-object is a way to treating code as data
; with ' prefix, the code is no longer a code for a module, but rather a list expression
; with "datum->syntax" we upgrade a datum to syntax-object
; syntax-object is just a datum with some extra information
; the first argument of "datum->syntax" is the context.
; We don't need any context yet, so we pass #f to context.

(define-macro (stacker-module-begin HANDLE-EXPR ...)
  #'(#%module-begin
     HANDLE-EXPR ...
     (display (first stack))))
(provide (rename-out [stacker-module-begin #%module-begin]))

(define stack empty)

(define (pop-stack!)
  (define arg (first stack))
  (set! stack (rest stack))
  arg)

(define (push-stack! arg)
  (set! stack (cons arg stack)))

(define (handle [arg #f]) ; by declaring arg with brackets with a default value we make it as a optional variable.
  (cond
    [(number? arg) (push-stack! arg)] ; if number? is true, then the expression of the right side of the branch are evaluated, if the condition fails, we move to the next branch
    [(or (equal? + arg) (equal? * arg))
     (define op-result (arg (pop-stack!) (pop-stack!))) ; if the or is true, we retrive the first two elements from stack and apply arg to these values.
     (push-stack! op-result)]))
(provide handle)

(provide + *)
