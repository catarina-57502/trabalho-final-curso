(in-package #:bag)


;; ;; \arg{root} must start and end with /.
;; ;; \arg{dir} must end with /.
;; ;; \arg{bak-p} dictates if a .bak is append to the end of the final filename
;; (defun resource-pathname (symbol &key root dir bak-p)
;;   (let ((root (or root
;;                   (namestring (asdf:system-relative-pathname :bag ""))))
;;         (dir (or dir
;;                  "resources"))
;;         (filename (uiop:strcat (string-downcase (symbol-name symbol)) "s.json" (if bak-p ".bak" ""))))
;;     (uiop:ensure-pathname (uiop:strcat root "/" dir "/" filename))))


;; to work in windows
(defun resource-pathname (symbol &key root dir bak-p)
  (declare (ignore root))
  (let ((dir (or dir
                 "resources"))
        (filename (uiop:strcat (string-downcase (symbol-name symbol)) "s.json" (if bak-p ".bak" ""))))
    (uiop:strcat dir "/" filename)))


;; Reads data from a .json file.
;; The \arg{keyword} will dictate the filename (e.g. :user -> users.json)
(defun read.resources (keyword &key root dir bak-p)
  (let ((class (alexandria:ensure-symbol keyword :bag))
        (file (resource-pathname keyword :root root :dir dir :bak-p bak-p)))
    (mapcar #'(lambda (i)
                (apply #'make-instance class (alexandria:alist-plist i)))
            (json:decode-json-from-string (uiop:read-file-string file)))))


;; Writes data to a .json file.
;; The class of the first object in \arg{list} will dictate the filename (e.g. user -> users.json)
(defun write.resources (list &key root dir bak-p)
  (when list
    (let* ((class (type-of (first list)))
           (file (resource-pathname class :root root :dir dir :bak-p bak-p)))
      (uiop:ensure-pathname file :ensure-directories-exist t)
      (uiop:with-output-file (out file :if-exists :supersede :if-does-not-exist :create)
        (format out "~a" (json:encode-json-to-string list))))))
