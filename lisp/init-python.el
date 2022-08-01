(use-package python
  :mode ("\\.py\\'" . python-mode)
             :interpreter ("/Users/HeBee/.pyenv/shims/ipython" . python-mode)
             ;; :init 
             ;; (setq 
             ;;  python-shell-interpreter-args "--simple-prompt -i"
             ;;  python-shell-interpreter "/Users/HeBee/.pyenv/shims/ipython")
  
             ;; (require-package 'pip-requirements)

             ;; (when (maybe-require-package 'anaconda-mode)
             ;;   (with-eval-after-load 'python
             ;;     ;; Anaconda doesn't work on remote servers without some work, so
             ;;     ;; by default we enable it only when working locally.
             ;;     (add-hook 'python-mode-hook
             ;;               (lambda () (unless (file-remote-p default-directory)
             ;;                            (anaconda-mode 1))))
             ;;     (add-hook 'anaconda-mode-hook
             ;;               (lambda ()
             ;;                 (anaconda-eldoc-mode (if anaconda-mode 1 0)))))
             ;;   (with-eval-after-load 'anaconda-mode
             ;;     (define-key anaconda-mode-map (kbd "M-?") nil))
             ;;   (when (maybe-require-package 'company-anaconda)
             ;;     (with-eval-after-load 'company
             ;;       (with-eval-after-load 'python
             ;;         (add-to-list 'company-backends 'company-anaconda)))))

             ;; (when (maybe-require-package 'company-anaconda)
             ;;   (add-to-list 'company-backends 'company-anaconda))
             ;; (when (maybe-require-package 'toml-mode)
             ;;   (add-to-list 'auto-mode-alist '("poetry\\.lock\\'" . toml-mode)))
             
             ;; (when (maybe-require-package 'reformatter)
             ;;   (reformatter-define black :program "black"))
             ;; :custom
             ;; (indent-tabs-mode nil)
             
             ;; :hook ((flycheck-mode anaconda-mode) . python-mode)
             ;; :config 
             ;; (add-hook 'python-mode-hook 'flycheck-mode)
             ;; (add-hook 'python-mode-hook 'company-mode)
             ;; (add-hook 'company-mode-hook 'company-anaconda)
              
             ;; (add-to-list 'company-backends 'company-anaconda)
             ;; (use-package anaconda-mode
             ;;   :ensure t
             ;;   )
             ;; (use-package company-mode
             ;;   :config (add-to-list (make-local-variable 'company-backends) 
             ;;                        '(company-anaconda))
             ;;   )                
             )
(use-package anaconda-mode
  :ensure t
  :config
  ;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode))
  (add-hook 'python-mode-hook 'anaconda-mode)
)

(use-package company-anaconda
  :ensure t
  :init (require 'rx)
  :config (add-to-list 'company-backends 'company-anaconda)
)
;; (provide 'init-python)
;; (add-to-list 'company-backends 'company-anaconda)
