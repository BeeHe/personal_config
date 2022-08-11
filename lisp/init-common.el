(require 'company)
(require 'company-sql)

(defun my-interactive-mode-cmd-hook ()
    (define-key evil-emacs-state-local-map (kbd "C-p") 
      'comint-previous-matching-input-from-input)
    (define-key evil-emacs-state-local-map (kbd "C-n") 
      'comint-next-matching-input-from-input)
    (define-key evil-emacs-state-local-map (kbd "C-r") 
      'comint-history-isearch-backward-regexp)
    ;; (define-key evil-emacs-state-local-map (kbd "TAB") 
    ;;   'sql-def-buffer-create-for-name-at-point)
)


(defun get-frame-persp (&optional frame)
  (persp-current-name))


(defun safe-persp-name (p)
  (if (member p (persp-names))
    (persp-current-name)))

;; (safe-persp-name (persp-current-name))

;; (message (safe-persp-name "test"))

(provide 'init-common)
