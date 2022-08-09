(use-package company
  :bind (
         :map company-active-map 
              ("C-n" . 'company-select-next)
              ("C-p" . 'company-select-previous))
  :config
  ;; (global-company-mode t)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (setq company-backends
        '((company-files
           company-keywords
           company-capf
           company-yasnippet
           )
          (company-abbrev company-dabbrev)))
)
