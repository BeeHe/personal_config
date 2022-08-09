(defun my/company-sql-upper-lower (&rest lst)
  (nconc (sort (mapcar 'upcase lst) 'string<) lst))

(defvar my/company-sql-alist
  `(("DBASE1"               ;; Database name w/o environment suffix.
     "DBASE1DM" "DBASE1UM"  ;; Database name with environment suffix.
     "SCHEMA1" "SCHEMA2"
     "TABLE1" "TABLE2"
     "COLUMN1" "COLUMN2")
    ("DBASE2"
     "DBASE2DM" "DBASE2UM"
     "SCHEMA1" "SCHEMA2"
     "TABLE1" "TABLE2"
     "COLUMN1" "COLUMN2"))
    "Alist mapping sql-mode to candidates.")

(defun my/company-sql (command &optional arg &rest ignored)
  "`company-mode' back-end for SQL mode based on database name."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'my/company-sql))
    (prefix (and (assoc (substring (buffer-name (current-buffer)) 4 -3) my/company-sql-alist)
                 (not (company-in-string-or-comment))
                 (or (company-grab-symbol) 'stop)))
    (candidates
     (let ((completion-ignore-case t)
           (symbols (cdr (assoc (substring (buffer-name (current-buffer)) 4 -3) my/company-sql-alist))))       
       (all-completions arg (if (consp symbols)
                                symbols
                              (cdr (assoc symbols company-sql-alist))))))
    (sorted t)))

(defun my/sql-open-database (database username password)
  "Open a SQLI process and name the SQL statement window with the name provided."
  (interactive (list
                (read-string "Database: ")
                (read-string "Username: ")
                (read-passwd "Password: ")))
  (let ((u-dbname (upcase database)))
    (setq sql-set-product "db2")

    (sql-db2 u-dbname)
    (sql-rename-buffer u-dbname)
    (setq sql-buffer (current-buffer))
    (sql-send-string (concat "CONNECT TO " database " USER " username " USING " password ";"))

    (other-window 1)
    (switch-to-buffer (concat "*DB:" u-dbname "*"))
    (sql-mode)
    (sql-set-product "db2")
    (setq sql-buffer (concat "*SQL: " u-dbname "*"))))
