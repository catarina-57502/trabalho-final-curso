(in-package #:bag)


(defun load-resources ()
  (setf *users* (read.resources :user))
  (setf *events* (read.resources :event)))


(defun run ()
  (load-resources)
  (server-start))

#+nil
(load-resources)

(defun stop ()
  (server-stop))
