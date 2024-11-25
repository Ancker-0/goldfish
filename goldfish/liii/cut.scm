;
; Copyright (C) 2024 The Goldfish Scheme Authors
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
; http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
; WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
; License for the specific language governing permissions and limitations
; under the License.
;

(define-library (liii cut)
(export cut cute)
(import (liii list)
        (liii error))
(begin
(define-macro (cut . paras)
  (letrec*
    ((slot? (lambda (x) (equal? '<> x)))
     (more-slot? (lambda (x) (equal? '<...> x)))
     (slots (filter slot? paras))
     (more-slots (filter more-slot? paras))
     (xs (map (lambda (x) (gensym)) slots))
     (rest (gensym))
     (parse
       (lambda (xs paras)
         (cond
           ((null? paras) paras)
           ((not (list? paras)) paras)
           ((more-slot? (car paras)) `(,rest ,@(parse xs (cdr paras))))
           ((slot? (car paras)) `(,(car xs) ,@(parse (cdr xs) (cdr paras))))
           (else `(,(car paras) ,@(parse xs (cdr paras))))))))
    (cond
      ((null? more-slots)
       `(lambda ,xs ,(parse xs paras)))
      (else
        (when
          (or (> (length more-slots) 1)
              (not (more-slot? (last paras))))
          (error 'syntax-error "<...> must be the last parameter of cut"))
        (let ((parsed (parse xs paras)))
          `(lambda (,@xs . ,rest) (apply ,@parsed)))))))
(define-macro (cute . paras)
  (error 'not-implemented))
))