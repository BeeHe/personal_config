;; evil settings

(defvar my-leader-map (make-sparse-keymap)
  "Keymap for \"leader key\" shortcuts.")

;; (require 'evil)
(use-package evil :ensure t 
  :init 
  (setq evil-want-C-u-scroll t
        evil-want-C-w-delete t
        )
  
  (unless (display-graphic-p)
    (require 'evil-terminal-cursor-changer)
    (evil-terminal-cursor-changer-activate) ; or (etcc-on)
    )
  ;; (evil-mode)
  ;; :bind (:map evil-normal-state-map "C-p" . nil)
  :custom 
  (evil-mode t)
  ;; (setq evil-defualt-state 'normal)
  ;; unbind C-p C-n in normal state
  ;; set leader key
  ;; telling-mode cursor
  ;; (setq evil-default-cursor t)
  ;; (setq evil-visual-state-cursor '("blue" box)
  ;;       evil-normal-state-cursr '("red" box)
  ;;       evil-insert-state-cursor '("orange" hbar)
  ;;       evil-emacs-state-cursor '("orange" bar)
  ;;       )  
  :config
  ;; basic settings
  (setq evil-ex-search-case 'smart)

  ;; (setq evil-emacs-state-cursor  '("gray" box))
  (setq evil-emacs-state-cursor  'hbar)
  (setq evil-insert-state-cursor 'bar)
  (setq evil-normal-state-cursor 'box)
  ;; change evil search mode to evil-search
  (evil-select-search-module 'evil-search-module 'evil-search)

  (defalias 'evil-insert-state 'evil-emacs-state)
  ;; (define-key evil-emacs-state-map (kbd "ESC ESC ESC") nil)
  (define-key evil-emacs-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-normal-state-map (kbd "C-p") nil)
  (define-key evil-normal-state-map (kbd "C-n") nil)
  (define-key evil-normal-state-map (kbd "TAB") 'indent-for-tab-command)
  (define-key evil-visual-state-map (kbd "TAB") 'indent-for-tab-command)
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-set-leader 'motion (kbd "SPC"))
  (define-key evil-normal-state-map (kbd "SPC") my-leader-map)
  (define-key evil-motion-state-map (kbd "SPC") my-leader-map)
  )

;; (define-prefix-command 'evil-window-map)
;; (define-key my-leader-map (kbd "w" ) 'evil-window-map)
;; (define-key evil-window-map "d" 'delete-window)
;; (define-key evil-window-map "\\" 'split-window-horizontally)
;; (define-key evil-window-map "-" 'split-window-vertically)
;; (define-key evil-normal-state-map (kbd "<leader>w") 'evil-window-map)

(define-key my-leader-map (kbd "bp") 'previous-buffer)
(define-key my-leader-map (kbd "bn") 'next-buffer)
(define-key my-leader-map (kbd "bb") 'swith-to-buffer)

(evil-mode 1)

