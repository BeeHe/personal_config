(with-eval-after-load 'eww

(setq-local endless/display-images t)

(defun endless/toggle-image-display ()
  "Toggle images display on current buffer."
  (interactive)
  (setq endless/display-images
        (null endless/display-images))
  (endless/backup-display-property endless/display-images))

(defun endless/backup-display-property (invert &optional object)
  "Move the 'display property at POS to 'display-backup.
Only applies if display property is an image.
If INVERT is non-nil, move from 'display-backup to 'display
instead.
Optional OBJECT specifies the string or buffer. Nil means current
buffer."
  (let* ((inhibit-read-only t)
         (from (if invert 'display-backup 'display))
         (to (if invert 'display 'display-backup))
         (pos (point-min))
         left prop)
    (while (and pos (/= pos (point-max)))
      (if (get-text-property pos from object)
          (setq left pos)
        (setq left (next-single-property-change pos from object)))
      (if (or (null left) (= left (point-max)))
          (setq pos nil)
        (setq prop (get-text-property left from object))
        (setq pos (or (next-single-property-change left from object)
                      (point-max)))
        (when (eq (car prop) 'image)
          (add-text-properties left pos (list from nil to prop) object))))))


(defun my/eww-toggle-images ()
  "Toggle whether images are loaded and reload the current page fro cache."
  (interactive)
  (setq-local shr-inhibit-images (not shr-inhibit-images))
  (eww-reload t)
  (message "Images are now %s"
           (if shr-inhibit-images "off" "on")))

(define-key eww-mode-map (kbd "I") #'my/eww-toggle-images)
(define-key eww-link-keymap (kbd "I") #'my/eww-toggle-images)

;; minimal rendering by default
(setq-default shr-inhibit-images t)   ; toggle with `I`
(setq-default shr-use-fonts nil)      ; toggle with `F`

);end with eveal after load eww

(use-package eww
  :config
  (setq 
    shr-use-fonts  nil                          ; No special fonts
    shr-use-colors nil                          ; No colours
    shr-indentation 2                           ; Left-side margin
    shr-width 70                                ; Fold text to 70 columns
    ;; https://global.bing.com/?mkt=en-us
    eww-search-prefix "https://bing.com/search?q=")    ; Use another engine for searching
  :bind
  (:map my-leader-map ("S" . 'eww))
  :hook
    (eww-mode . my-eww-keybind-hook)
  )

 ;;  :after ((setq
 ;; ;; browse-url-browser-function 'eww-browse-url ; Use eww as the default browser
 ;;           ))
