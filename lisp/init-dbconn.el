(setq sql-postgres-login-params
      '((user :default "postgres")
        (database :default "postgres")
        (server :default "localhost")
        (port :default 5432)))
;; (setq sql-connection-alist
;;       '((pgsql-local (sql-product 'postgres)
;;                     (sql-port 5432)
;;                     (sql-server "localhost")
;;                     (sql-user "postgres")
;;                     (sql-password "postgres")
;;                     (sql-database "postgres"))
;;         ;; (pgsql-staging (sql-product 'postgres)
;;         ;;                (sql-port 5432)
;;         ;;                (sql-server "db.staging.com")
;;         ;;                (sql-user "user")
;;         ;;                (sql-password "password")
;;         ;;                (sql-database "my-app"))
;;         (mysql-dev (sql-product 'mysql)
;;                    (sql-port 5432)
;;                    (sql-server "localhost")
;;                    (sql-user "user")
;;                    (sql-password "password")
;;                    (sql-database "some-app"))
;;         (ora-local (sql-product 'oracle)
;;                    (sql-user "sys")
;;                    (sql-password "oracle")
;;                    (sql-database "docker_ora as sysdba"))))


(defun sql-connect-to-pqsql-local ()
  (interactive)
  (sql-connect 'test-pg "*pg-local*"))


(defun sql-connect-to-ora-docker()
  (interactive)
  (sql-connect 'oracle-prod "*ora-local*"))

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
                (sql-user "emas_dev")
                (sql-database "emas"))
        ))

(setenv "PGPASSFILE" "/Users/HeBee/.pgpass")

(defun my-sql-connect (product connection)
  (setq sql-product product)
  (sql-connect connection))

(defun my/sql-cvault-18 ()
  (interactive)
  (my-sql-connect 'postgres 'cvault-18))

(defun my/sql-cdbmeta-25 ()
  (interactive)
  (my-sql-connect 'postgres 'cdbmeta-25))

(defun my/sql-test-pg ()
  (interactive)
  (my-sql-connect 'postgres 'test-pg))

;; set to connectio 
(defvar my-sql-servers-list
  '(("local" my/sql-test-pg)
    ("Server 2" sql-connect-to-pqsql-local))
  "Alist of server name and the function to connect")

(defun my-sql-connect-server (func)
  "Connect to the input server using my-sql-servers-list"
  (interactive
   (cdr
    (assoc
     (completing-read "SELECT server" my-sql-servers-list) 
     my-sql-servers-list)))
  (funcall func))

(define-key my-leader-map (kbd "cc") 'my-sql-connect-server)


;; (setq lsp-sqls-workspace-config-path nil)
(setq lsp-sqls-connections
    '(((driver . "postgresql") (dataSourceName . "host=127.0.0.1 port=5432 user=hebee dbname=postgres sslmode=disable"))))
