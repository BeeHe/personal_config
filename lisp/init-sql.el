(setq sql-connection-alist
    '((cvault-18 (sql-product 'postgres)
                    (sql-port 5000)
                    (sql-server "10.197.170.18")
                    (sql-user "clupapp")
                    (sql-database "clup"))
        (cdbmeta-25 (sql-product 'postgres)
                    (sql-port 5432)
                    (sql-server "10.197.168.25")
                    (sql-user "cdbmgr")
                    (sql-database "cdbmgr"))
        (test-pg (sql-product 'postgres)
                (sql-port 5432)
                (sql-server "localhost")
                (sql-user "hebee")
                (sql-database "postgres"))
        ))

(setenv "PGPASSFILE" "/Users/HeBee/.pgpass")

(defun my/sql-cvault-18 ()
  (interactive)
  (my-sql-connect 'postgres 'cvault-18)
  )

(defun my/sql-cdbmeta-25 ()
  (interactive)
  (my-sql-connect 'postgres 'cdbmeta-25)
  )

(defun my/sql-test-pg ()
  (interactive)
  (my-sql-connect 'postgres 'test-pg)
  )

(defun my-sql-connect (product connection)
  (setq sql-product product)
  (sql-connect connection)
  )

;; set to connectio 
(defvar my-sql-servers-list
  '(("local" 'my/sql-test-pg)
    ("Server 2" 'my-sql-server2))
  "Alist of server name and the function to connect")

(defun my-sql-connect-server (func)
  "Connect to the input server using my-sql-servers-list"
  (interactive
   (cdr(
        assoc(
              completing-read "SELECT server" my-sql-servers-list
                              ) my-sql-servers-list)))
  (funcall func))

(define-key my-leader-map (kbd "cc") 'my-sql-connect-server)


;; use-package config

(use-package sqlformat
  :commands (sqlformat sqlformat-buffer sqlformat-region)
  :hook (sql-mode . sqlformat-on-save-mode)
  :init
  (setq sqlformat-command 'sqlformat)
  (setq seql-format-rags '("-r" "--indent_width 2" "-k upper" "-s" "-a" "--indent_columns")))

;; set sql history
(defun my-sql-save-history-hook ()
  (let ((lval 'sql-input-ring-file-name)
        (rval 'sql-product))
    (if (symbol-value rval)
        (let ((filename 
               (concat "~/.emacs.d/sql/"
                       (symbol-name (symbol-value rval))
                       "-history.sql")))
          (set (make-local-variable lval) filename))
      (error
       (format "SQL history will not be saved because %s is nil"
               (symbol-name rval))))))

;; (add-hook 'sql-interactive-mode-hook 'my-sql-save-history-hook)
;; ;; SQL select result autoformat
;; (add-hook 'sql-interactive-mode-hook
;;           (lambda ()
;;             (toggle-truncate-lines t)))

(use-package sql-mode
  :mode (("\\.sql$" . sql-mode))
  :hook
  ;; (sql-interactive-mode . 'my-sql-save-history-hook)
  (sql-interactive-mode . (lambda () 
                            (toggle-truncate-lines t))))
