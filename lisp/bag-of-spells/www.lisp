(in-package #:bag)


;; ;; see: https://github.com/mmontone/djula/blob/master/demo/demo.lisp
;; ;;
;; ;; FIXME
;; ;;    -- using the `define-static-resource' from the above link is not working withing docker


;; (djula:add-template-directory (asdf:system-relative-pathname :bag "templates/"))


;; (defparameter +base.html+ (djula:compile-template* "base.html"))


;; (defparameter +home.html+ (djula:compile-template* "home.html"))


;; (defparameter +users.html+ (djula:compile-template* "users.html"))


;; (defparameter +events.html+ (djula:compile-template* "events.html"))


;; (easy-routes:defroute index ("/") ()
;;   (djula:render-template* +home.html+
;;                           nil))


;; ;; this responds with a web page using:
;; ;;   (1) http://localhost:8080/users
;; (easy-routes:defroute www-users ("/users") ()
;;   (djula:render-template* +users.html+
;;                           nil
;;                           :users (get-users)))


;; ;; this responds with a web page using:
;; ;;   (1) http://localhost:8080/events
;; (easy-routes:defroute www-events ("/events") ()
;;   (djula:render-template* +events.html+
;;                           nil
;;                           :events (get-events)))


;; ;; TODO add new user
;; ;; (let ((new-id 99))
;; ;;   (easy-routes:defroute new-user ("/user" :method :post :decorators (@json @auth)) (name)
;; ;;     (hunchentoot::log-message* :warning "REGISTERING NEW USER: '~a'" name)
;; ;;     (let ((new-user (make-instance 'user :id (incf new-id)
;; ;;                                          :name name
;; ;;                                          :username "my-user-name"
;; ;;                                          :email "email@world.universe"
;; ;;                                          :address "somwhere over the rainbow..."
;; ;;                                          :phone "et phone home..."
;; ;;                                          :website "plz no!"
;; ;;                                          :company "void")))
;; ;;       (add-user new-user)
;; ;;       (write.resources (get-users) :bak-p t) ; tem a grande desvantagem de estar sempre a gravar os dados todos (mas está a fazer para 1 ficheiro com .bak - preserva o original)
;; ;;       (json:encode-json-to-string new-user))))
