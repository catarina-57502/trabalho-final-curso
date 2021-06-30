(in-package #:bag)


;; TODO for now is only a few global variables, but in the future it should be using a real database


(defparameter *users* nil)


(defun get-users ()
  *users*)


(defun add-user (new-user)
  (push new-user *users*))


(defparameter *events* nil)


(defun get-events ()
  *events*)


(defun add-event (new-event)
  (push new-event *events*))


(defun find-user (id)
  (find id *users* :key #'id))


(defun save-users ()
  (write.resources *users*))

(defun find-event (id)
  (find id *events* :key #'id))


(defun save-events ()
  (write.resources *events*))
