(in-package #:bag)


(defparameter *server* nil)


(defun server-stop ()
  (when (and *server*
             (hunchentoot:started-p *server*))
    (hunchentoot:stop *server*))
  (setf *server* nil))


(defun server-start (&key (port 8080))
  (server-stop)
  (setf *server* (make-instance 'easy-routes:routes-acceptor
                                :port port))
  (hunchentoot:start *server*))


;; TODO
(defun @auth (next)
  (funcall next)
  #+nil
  (let ((user (hunchentoot:session-value 'user)))
    (if user
        (funcall next) ;; (hunchentoot:redirect "/login")
        (easy-routes::permission-denied-error))))


(defun @html (next)
  (setf (hunchentoot:content-type*) "text/html")
  (funcall next))


(defun @json (next)
  (setf (hunchentoot:content-type*) "application/json")
  (funcall next))


;; TODO
;; (defun @db (next)
;;   (postmodern:with-connection *db-spec*
;;     (funcall next)))
