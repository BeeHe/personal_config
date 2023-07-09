(use-package docker
  :ensure t
  :hook (docker-image-mode 'docker-image-keybind-define)
  )

;; (define-key my-leader-map (kbd "dv") docker-volume-mode-map)
;; (define-key my-leader-map (kbd "di") docker-image-mode-map)
;; (define-key my-leader-map (kbd "dc") docker-container-mode-map)
;; (define-key my-leader-map (kbd "dn") docker-network-mode-map)
;; (define-key my-leader-map (kbd "dC") docker-context-mode-map)


(defun docker-image-keybind-define()
     ;; (define-key evil-normal-state-local-map (kbd "k") 'previous-line)
     ;; (define-key evil-normal-state-local-map (kbd "j") 'previous-line)
     ;; (define-key evil-normal-state-local-map (kbd "b") 'backward-button)
     ;; (define-key evil-normal-state-local-map (kbd "f") 'forward-button)
     ;; (define-key evil-normal-state-local-map (kbd "v") 'mouse-select-window)
     (define-key evil-normal-state-local-map (kbd "ls") 'docker-image-ls)
     (define-key evil-normal-state-local-map (kbd "ll") 'docker-image-ls-arguments)
     (define-key evil-normal-state-local-map (kbd "R") 'docker-image-run)
     (define-key evil-normal-state-local-map (kbd "P") 'docker-image-push)
     (define-key evil-normal-state-local-map (kbd "I") 'docker-image-inspect)
     (define-key evil-normal-state-local-map (kbd "H") 'docker-image-help)
)
