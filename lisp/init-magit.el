(use-package magit
  :ensure t
  :bind (
         (:map 
          my-leader-map ("g" . 'magit))
         ("C-x g" . magit-status))
  )
