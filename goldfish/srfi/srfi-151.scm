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

(define-library (srfi srfi-151)
(export
  bitwise-not bitwise-and bitwise-ior bitwise-xor bitwise-nor bitwise-nand
  arithmetic-shift
)
(begin

(define bitwise-not lognot)

(define bitwise-and logand)

(define bitwise-ior logior)

(define bitwise-xor logxor)

(define (bitwise-nor a b)  
        (lognot (bitwise-ior a b)))

(define (bitwise-nand a b)  
        (lognot (bitwise-and a b)))

(define arithmetic-shift ash)

) ; end of begin
) ; end of define-library

