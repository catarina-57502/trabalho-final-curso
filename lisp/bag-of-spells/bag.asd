(asdf:defsystem #:bag
  :depends-on (#:alexandria
               #:hunchentoot
               #:cl-json
               #:easy-routes
               #:djula)
  :serial t
  :components ((:file "package")
               (:file "net")
               (:file "models")
               (:file "resources")
               (:file "db")
               (:file "api")
               (:file "www")
               (:file "main")))
