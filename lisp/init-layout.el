;; C-x r j <register> C-x r w <register>
;; (require 'init-evil)
(define-key my-leader-map (kbd "wr") 'window-configuration-to-register)
(define-key my-leader-map (kbd "wj") 'jump-to-register)
