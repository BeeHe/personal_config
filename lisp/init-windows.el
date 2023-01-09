;; emcas windows config
(winner-mode 1)

(define-prefix-command 'evil-window-map)
(define-key my-leader-map (kbd "w" ) 'evil-window-map)
(define-key evil-window-map "d" 'delete-window)
(define-key evil-window-map "\\" 'split-window-horizontally)
(define-key evil-window-map "-" 'split-window-vertically)
(define-key evil-window-map "l" 'windmove-right)
(define-key evil-window-map "h" 'windmove-left)
(define-key evil-window-map "j" 'windmove-down)
(define-key evil-window-map "k" 'windmove-up)
(define-key evil-window-map "k" 'windmove-up)
(define-key evil-window-map "s" 'window-configuration-to-register)
(define-key evil-window-map "r" 'jump-to-register)

(define-key evil-normal-state-map (kbd "<leader>w") 'evil-window-map)


;; window settings
(define-key evil-normal-state-map (kbd "C-x \\") 'split-window-horizontally)
(define-key evil-normal-state-map (kbd "C-x -") 'split-window-vertically)
(define-key evil-normal-state-map (kbd "M-l") 'windmove-right)
(define-key evil-normal-state-map (kbd "M-h") 'windmove-left)
(define-key evil-normal-state-map (kbd "M-j") 'windmove-down)
(define-key evil-normal-state-map (kbd "M-k") 'windmove-up)

;; emacs-state settings
(define-key evil-insert-state-map (kbd "C-x \\") 'split-window-horizontally)
(define-key evil-insert-state-map (kbd "C-x -") 'split-window-vertically)

(define-key evil-motion-state-map (kbd "M-l") 'windmove-right)
(define-key evil-motion-state-map (kbd "M-h") 'windmove-left)
(define-key evil-motion-state-map (kbd "M-j") 'windmove-down)
(define-key evil-motion-state-map (kbd "M-k") 'windmove-up)



;; register settings
(define-prefix-command 'evil-register-map)
(define-key my-leader-map (kbd "r" ) 'evil-register-map)

(define-key evil-register-map (kbd "w") 'window-configuration-to-register)
(define-key evil-register-map (kbd "j") 'jump-to-register)


;; zoom-window mode
;; (with-eval-after-load "persp-mode-autoloads"
;;   (add-hook 'after-init-hook #'(lambda () (persp-mode 1))))

(use-package zoom-window
  :ensure t
  :config (custom-set-variables '(zoom-window-mode-line-color "black"))
           ;; (custom-set-variables '(zoom-window-use-persp t))
           ;; (zoom-window-setup)
  :bind (:map global-map ("C-x z" . 'zoom-window-zoom))
)
;; (require 'zoom-window)
;; (custom-set-variables
;;  '(zoom-window-use-persp t))
;; (zoom-window-setup)
;; (global-set-key (kbd "C-x z") 'zoom-window-zoom)

(use-package diminish
  :ensure t
  ) 
(diminish 'ivy-mode)
(diminish 'projectile-mode)
(diminish 'company-mode)
(diminish 'ELDoc)

