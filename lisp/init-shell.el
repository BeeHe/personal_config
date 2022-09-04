(require 'init-common)
(use-package ehell
  :hook
  (eshell-mode . my-sql-servers-list))

