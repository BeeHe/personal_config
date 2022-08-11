
;; use-package config

(use-package sqlformat
  :commands (sqlformat sqlformat-buffer sqlformat-region)
  ;; :hook (sql-mode . sqlformat-on-save-mode)
  :init
  (setq sqlformat-command 'sqlformat)
  (setq seql-format-rags '("-r" "--indent_width 2" "-k upper" "-s" "-a" "--indent_columns")))

;; set sql history
(defun my-sql-save-history-hook()
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

(require 'init-common)
(require 'company-sql)
;; (declare-function my-sql-interactive-mode-cmd-hook "init-common")
;; (declare-function toggle-truncate-lines "init-common")
(use-package sql
  :mode (".*\\.sql$" . sql-mode)
  :bind (
         :map my-leader-map
              ("cb" . 'sql-set-sqli-buffer))
  ;; :config
  :hook
  (sql-mode . lsp)
  (sql-interactive-mode . my-sql-save-history-hook)
  ;; SQL select result autoformat
  (sql-interactive-mode . (lambda () (toggle-truncate-lines t)))
  ;; (sql-interactive-mode . (lambda () (add-to-list 'company-backends 'company-sql)))
  (sql-interactive-mode . my-interactive-mode-cmd-hook)
)

;; (use-package sql-interactive-mode
;;   :ensure nil
;;   :bind (
;;          :map evil-emacs-state-local-map 
;;               ("C-p" . 'comint-previous-matching-input-from-input)
;;               ("C-n" . 'comint-next-matching-input-from-input))
;;   )



;; send tab to psql to completion
(defun my-comint-send-string (string)
  "Send string to comint buffers. Useful for *compilation* read-only buffer."
  (interactive
   (list (read-input "Type string: " nil 'my-comint-send-hist-list)))
  (comint-send-string (get-buffer-process (current-buffer)) string))
;; (define-key evil-emacs-state-local-map [TAB] 'my-comint-send-string)
