(use-package projectile
  :ensure t
 :init (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map))
  :config 
  (setq projectile-project-search-path 
                '("~/Work/work_git/" "~/rust/projects/" "~/PersonalData/")) 

  (define-key my-leader-map (kbd "p" ) 'projectile-command-map)
)
;; (define-key evil-normal-state-map (kbd "<leader>p") 'projectile-command-map)


;; prespective keybinds
;; s — persp-switch: Query a perspective to switch to, or create
;; ` — persp-switch-by-number: Switch to perspective by number, or switch quickly using numbers 1, 2, 3.. 0 as prefix args; note this will probably be most useful with persp-sort set to 'created
;; k — persp-remove-buffer: Query a buffer to remove from current perspective
;; c — persp-kill : Query a perspective to kill
;; r — persp-rename: Rename current perspective
;; a — persp-add-buffer: Query an open buffer to add to current perspective
;; A — persp-set-buffer: Add buffer to current perspective and remove it from all others
;; b - persp-switch-to-buffer: Like switch-to-buffer; includes all buffers from all perspectives; changes perspective if necessary
;; i — persp-import: Import a given perspective from another frame.
;; n, <right> — persp-next: Switch to next perspective
;; p, <left> — persp-prev: Switch to previous perspective
;; C-s — persp-state-save: Save all perspectives in all frames to a file
;; C-l — persp-state-load: Load all perspectives from a file


;; perspective settings
(use-package perspective
  :bind
  (
   ("C-x C-b" . persp-list-buffers)   ; or use a nicer switcher, see below
   :map perspective-map
   ("N" . persp-prev)
   ;; ("L" . persp-switch-by-number)
   ("l" . persp-list-buffers)   ; or use a nicer switcher, see below
   )
  :init
  (persp-mode)
  :config
  (define-key my-leader-map (kbd "l") 'perspective-map)
)