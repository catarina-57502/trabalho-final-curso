(in-package #:bag)


;; ;; this responds with a json response using:
;; ;;   (1) http://localhost:8080/users/
;; (easy-routes:defroute users-api ("/users" :decorators (@json @auth)) ()
;;   (json:encode-json-to-string (get-users)))


;; this responds with a json response using:
;;   (1) http://localhost:8080/users/
;;   (2) http://localhost:8080/users/3
(easy-routes:defroute user-api ("/users/:id" :method :get :decorators (@json @auth)) ()
  (json:encode-json-to-string (if (alexandria:emptyp id)
                                  (get-users)
                                  (let ((id (json:decode-json-from-string id)))
                                    (remove-if-not #'(lambda (user.id)
                                                       (= user.id id))
                                                   (get-users)
                                                   :key #'id)))))


;; ;; this responds with a json response using:
;; ;;   (1) http://localhost:8080/events/
;; (easy-routes:defroute events-api ("/events" :decorators (@json @auth)) ()
;;   (json:encode-json-to-string (get-events)))


;; this responds with a json response using:
;;   (1) http://localhost:8080/events/
;;   (2) http://localhost:8080/events/3
(easy-routes:defroute event-api ("/events/:id" :method :get :decorators (@json @auth)) ()
  (json:encode-json-to-string (if (alexandria:emptyp id)
                                  (get-events)
                                  (let ((id (json:decode-json-from-string id)))
                                    (remove-if-not #'(lambda (event.id)
                                                       (= event.id id))
                                                   (get-events)
                                                   :key #'id)))))

(easy-routes:defroute user-api-post ("/update-user" :method :post :decorators (@json @auth)) (id approved)
  (unless (alexandria:emptyp id)
    (let* ((id (json:decode-json-from-string id))
           (user (find-user id)))
      (when user
        (setf (approved-p user) (json:decode-json-from-string approved))
        (save-users)
        (json:encode-json-to-string user)))))

(easy-routes:defroute event-api-post ("/update-event" :method :post :decorators (@json @auth)) (id approved)
  (unless (alexandria:emptyp id)
    (let* ((id (json:decode-json-from-string id))
           (event (find-event id)))
      (when event
        (setf (approved-p event) (json:decode-json-from-string approved))
        (save-events)
        (json:encode-json-to-string event)))))

