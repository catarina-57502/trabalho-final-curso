(In-package #:bag)


;; FIXME
;;   -- maybe `admin-p' and `approved-p' should be in another 'data' area?
;;   -- `cc' and some other fields should be only :reader?


;; this must match with the .json users file
(defclass user ()
  ((id       :reader id       :initarg :id)
   (username :reader username :initarg :username)
   ;;
   (admin-p    :accessor admin-p    :initarg :admin-p)
   (approved-p :accessor approved-p :initarg :approved-p)
   ;;
   (cc        :accessor cc        :initarg :cc)
   (name      :accessor name      :initarg :name)
   (email     :accessor email     :initarg :email)
   (birthdate :accessor birthdate :initarg :birthdate)
   (tshirt    :accessor tshirt    :initarg :tshirt)
   (office    :accessor office    :initarg :office)
   (plafond   :accessor plafond   :initarg :plafond)
   (password  :accessor password  :initarg :password)))


(defmethod print-object ((object user) stream)
  (print-unreadable-object (object stream :type t)
    (with-slots (id username) object
      (format stream "id: ~a username: ~a" id username))))


;; this must match with the .json events file
(defclass event ()
  ((id :reader id :initarg :id)
   ;;
   (approved-p :accessor approved-p :initarg :approved-p)
   ;;
   (name       :accessor name       :initarg :name)
   (location   :accessor location   :initarg :location)
   (date       :accessor date       :initarg :date)
   (due-date   :accessor due.date   :initarg :due-date)
   (url        :accessor url        :initarg :url)
   (activities :accessor activities :initarg :activities)
   ;;
   (img        :accessor img        :initarg :img)
   (cost       :accessor cost       :initarg :cost)
   (rating     :accessor rating     :initarg :rating)))
   


(defmethod print-object ((object event) stream)
  (print-unreadable-object (object stream :type t)
    (with-slots (id name) object
      (format stream "id: ~a name: ~a" id name))))
