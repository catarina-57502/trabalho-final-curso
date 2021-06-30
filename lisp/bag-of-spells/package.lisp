(cl:in-package #:cl-user)

(defpackage #:bag
  (:use #:cl
        ;; #:hunchentoot
        ;; #:cl-who
        ;; #:cl-json
        )
  (:export #:run
           #:stop))
