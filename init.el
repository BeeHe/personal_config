;; backup and file related
;; (setq user-emacs-direcotry "/Users/HeBee/PersonalData/.emacs.d")
;; (setq package-user-dir "/Users/HeBee/PersonalData/.emacs.d/elpa")
(setq inhibit-startup-screen t)


(defun xah-get-fullpath (@file-relative-path)
  "Return the full path of *file-relative-path, relative to caller's file location.

Example: If you have this line
 (xah-get-fullpath \"../xyz.el\")
in the file at
 /home/mary/emacs/emacs_lib.el
then the return value is
 /home/mary/xyz.el
Regardless how or where emacs_lib.el is called.

This function solves 2 problems.

① If you have file A, that calls the `load' on a file at B, and B calls `load' on file C
  using a relative path, then Emacs will complain about unable to find C.
  Because, emacs does not switch current directory with `load'.

  To solve this problem, when your code only knows the relative path of another file C,
  you can use the variable `load-file-name' to get the current file's full path,
  then use that with the relative path to get a full path of the file you are interested.

② To know the current file's full path, emacs has 2 ways: `load-file-name' and `buffer-file-name'.
  If the file is loaded by `load', then `load-file-name' works but `buffer-file-name' doesn't.
  If the file is called by `eval-buffer', then `load-file-name' is nil.
  You want to be able to get the current file's full path regardless the file is run by `load'
  or interactively by `eval-buffer'."
  (concat (file-name-directory (or load-file-name buffer-file-name "$HOME/.emacs.d/init.el"))
          @file-relative-path)
)

;; use to require package
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (or (package-installed-p package min-version)
      (let* ((known (cdr (assoc package package-archive-contents)))
             (best (car (sort known (lambda (a b)
                                      (version-list-<= (package-desc-version b)
                                                       (package-desc-version a)))))))
        (if (and best (version-list-<= min-version (package-desc-version best)))
            (package-install best)
          (if no-refresh
              (error "No version of %s >= %S is available" package min-version)
            (package-refresh-contents)
            (require-package package min-version t)))
        (package-installed-p package min-version))))

(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install optional package `%s': %S" package err)
     nil)))

(defun xah-save-all-unsaved ()
    "Save all unsaved files. no ask.
Version 2019-11-05"
    (interactive)
    (save-some-buffers t ))

(if (version< emacs-version "27")
    (add-hook 'focus-out-hook 'xah-save-all-unsaved)
  (setq after-focus-change-function 'xah-save-all-unsaved))

(setq make-backup-files nil)
(setq backup-by-copying t)
(setq create-lockfiles nil)
(setq auto-save-default nil)

(require 'recentf)
(recentf-mode 1)

;; (desktop-save-mode 1)
(global-auto-revert-mode 1)

;; HHH___________________________________________________________________
;; user interface

;; (when (version<= "26.0.50" emacs-version )

(setq-default display-line-numbers-type 'relative
      display-line-numbers-width-start 4)

(global-display-line-numbers-mode t)
;;   (global-display-line-numbers-mode))

;; (column-number-mode t)
(blink-cursor-mode 0)
(setq use-dialog-box nil)

(if (display-graphic-p)
    (progn
      (scroll-bar-mode -1)
      (toggle-frame-fullscreen)))

;; (progn
;;   ;; no need to warn
;;   (put 'narrow-to-region 'disabled nil)
;;   (put 'narrow-to-page 'disabled nil)
;;   (put 'upcase-region 'disabled nil)
;;   (put 'downcase-region 'disabled nil)
;;   (put 'erase-buffer 'disabled nil)
;;   (put 'scroll-left 'disabled nil)
;;   (put 'dired-find-alternate-file 'disabled nil)
;;   )

;; HHH___________________________________________________________________

(progn
  (require 'dired-x)
  (setq dired-dwim-target t)
  (when (string-equal system-type "gnu/linux")
    (setq dired-listing-switches "-al --time-style long-iso"))
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always))

;; HHH___________________________________________________________________
;;
(setq set-mark-command-repeat-pop t)
(setq mark-ring-max 5)
(setq global-mark-ring-max 5)

;; HHH___________________________________________________________________
;; Emacs: Font Setup http://ergoemacs.org/emacs/emacs_list_and_set_font.html

;; set default font

;; ;; set font for emoji
;; (set-fontset-font
;;  t
;;  '(#x1f300 . #x1fad0)
;;  (cond
;;   ((member "Noto Color Emoji" (font-family-list)) "Noto Color Emoji")
;;   ((member "Noto Emoji" (font-family-list)) "Noto Emoji")
;;   ((member "Segoe UI Emoji" (font-family-list)) "Segoe UI Emoji")
;;   ((member "Symbola" (font-family-list)) "Symbola")
;;   ((member "Apple Color Emoji" (font-family-list)) "Apple Color Emoji"))
;;  ;; Apple Color Emoji should be before Symbola, but Richard Stallman skum disabled it.
;;  ;; GNU Emacs Removes Color Emoji Support on the Mac
;;  ;; http://ergoemacs.org/misc/emacs_macos_emoji.html
;;  )

;; set font for chinese characters
;; (set-fontset-font
;;  t
;;  '(#x4e00 . #x9fff)
;;  (cond
;;   ((string-equal system-type "windows-nt")
;;    (cond
;;     ((member "Microsoft YaHei" (font-family-list)) "Microsoft YaHei")
;;     ((member "Microsoft JhengHei" (font-family-list)) "Microsoft JhengHei")
;;     ((member "SimHei" (font-family-list)) "SimHei")))
;;   ((string-equal system-type "darwin")
;;    (cond
;;     ((member "Hei" (font-family-list)) "Hei")
;;     ((member "Heiti SC" (font-family-list)) "Heiti SC")
;;     ((member "Heiti TC" (font-family-list)) "Heiti TC")))
;;     ))
;;   ((string-equal system-type "gnu/linux")
;;    (cond
;;     ((member "WenQuanYi Micro Hei" (font-family-list)) "WenQuanYi Micro Hei")))))

(set-frame-font
       (cond
        ((string-equal system-type "windows-nt")
         (if (member "Consolas" (font-family-list)) (format "Consolas-%s" 14) nil))
        ((string-equal system-type "darwin")
         (if (member "Monaco" (font-family-list)) (format "Monaco-%s" 13) nil))
        ((string-equal system-type "gnu/linux")
         (if (member "DejaVu Sans Mono" (font-family-list)) "DejaVu Sans Mono" nil))
        (t nil)))



;; HHH___________________________________________________________________

(progn
  ;; minibuffer setup
  (setq enable-recursive-minibuffers t)
  (savehist-mode 1)
  ;; big minibuffer height, for ido to show choices vertically
  (setq max-mini-window-height 0.5)
  ;; minibuffer, stop cursor going into prompt
  (customize-set-variable
   'minibuffer-prompt-properties
   (quote (read-only t cursor-intangible t face minibuffer-prompt))))

(progn
  ;; minibuffer enhanced completion
  (require 'icomplete)
  (icomplete-mode 1)
  ;; show choices vertically
  (setq icomplete-separator "\n")
  (setq icomplete-hide-common-prefix nil)
  (setq icomplete-in-buffer t)
  (define-key icomplete-minibuffer-map (kbd "<right>") 'icomplete-forward-completions)
  (define-key icomplete-minibuffer-map (kbd "<left>") 'icomplete-backward-completions))

;; (progn
;;   ;; make buffer switch command do suggestions, also for find-file command
;;   (require 'ido)
;;   (ido-mode 1)

;;   ;; show choices vertically
;;   (if (version< emacs-version "25")
;;       (progn
;; 	(make-local-variable 'ido-separator)
;; 	(setq ido-separator "\n"))
;;     (progn
;;       (make-local-variable 'ido-decorations)
;;       (setf (nth 2 ido-decorations) "\n")))

;;   ;; show any name that has the chars you typed
;;   (setq ido-enable-flex-matching t)
;;   ;; use current pane for newly opened file
;;   (setq ido-default-file-method 'selected-window)
;;   ;; use current pane for newly switched buffer
;;   (setq ido-default-buffer-method 'selected-window)
;;   ;; stop ido from suggesting when naming new file
;;   (when (boundp 'ido-minor-mode-map-entry)
;;     (define-key (cdr ido-minor-mode-map-entry) [remap write-file] nil)))

;; HHH___________________________________________________________________

;; remember cursor position
(if (version< emacs-version "25.0")
    (progn
      (require 'saveplace)
      (setq-default save-place t))
  (save-place-mode 1))


;; make typing delete/overwrites selected text
(delete-selection-mode 1)

(setq shift-select-mode nil)

(electric-pair-mode 1)

;; set highlighting brackets
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

;; for isearch-forward, make these equivalent: space newline tab hyphen underscore
(setq search-whitespace-regexp "[-_ \t\n]+")

(defun xah-toggle-search-whitespace ()
    "Set `search-whitespace-regexp' to nil or includes hyphen lowline tab newline.
Explanation: When in isearch (M-x `isearch-forward'), space key can also stand for other chars such as hyphen lowline tab newline. It depend on a regex. It's convenient. But sometimes you want literal. This command makes it easy to toggle.

Emacs Isearch Space Toggle
http://ergoemacs.org/emacs/emacs_isearch_space.html
Version 2019-02-22"
    (interactive)
    (if (string-equal search-whitespace-regexp nil)
	(progn
	  (setq search-whitespace-regexp "[-_ \t\n]+")
	  (message "Space set to hyphen lowline tab newline space"))
      (progn
	(setq search-whitespace-regexp nil)
	(message "Space set to literal."))))

;; 2015-07-04 bug of pasting in emacs.
;; http://debbugs.gnu.org/cgi/bugreport.cgi?bug=16737#17
;; http://ergoemacs.org/misc/emacs_bug_cant_paste_2015.html
;; (setq x-selection-timeout 300)
(setq save-interprogram-paste-before-kill t)
(setq x-select-enable-clipboard-manager nil)

;; HHH___________________________________________________________________
;; indentation, end of line

(electric-indent-mode 0)

(set-default 'tab-always-indent 'complete)

;; no mixed tab space
(setq-default indent-tabs-mode nil)
					; gnu emacs 23.1, 24.4.1 default is t

;; 4 is more popular than 8.
(setq-default tab-width 4)

(setq sentence-end-double-space nil )

;; HHH___________________________________________________________________

;; load emacs 24's package system. Add MELPA repository.
;; (when (>= emacs-major-version 24)
;;   (require 'package)
;;   (add-to-list
;;    'package-archives
;;   '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
;;   '("melpa" . "https://melpa.org/packages/")
;;  t))
(setq package-archives '(("gnu" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/gnu/")
                         ("melpa" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/melpa/")))

;; (setq package-archives
;;  '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;    ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
      ;; '(("melpa" . "https://gitlab.com/d12frosted/elpa-mirror/raw/master/melpa/")
      ;;   ("org"   . "https://gitlab.com/d12frosted/elpa-mirror/raw/master/org/")
      ;;   ("gnu"   . "https://gitlab.com/d12frosted/elpa-mirror/raw/master/gnu/")))
(package-initialize) ;; You might already have this line

;; HHH___________________________________________________________________

(progn
  ;; Make whitespace-mode with very basic background coloring for whitespaces.
  ;; http://ergoemacs.org/emacs/whitespace-mode.html
  (setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark )))

  ;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
  (setq whitespace-display-mappings
	;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
	'(
	  (space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
	  (newline-mark 10 [182 10]) ; LINE FEED,
	  (tab-mark 9 [9655 9] [92 9]) ; tab
	  )))

;; HHH___________________________________________________________________
;; edit related

(setq hippie-expand-try-functions-list
      '(
	try-expand-dabbrev
	try-expand-dabbrev-all-buffers
	;; try-expand-dabbrev-from-kill
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol
	try-complete-file-name-partially
	try-complete-file-name
	;; try-expand-all-abbrevs
	;; try-expand-list
	;; try-expand-line
	))

;; HHH___________________________________________________________________

;; convenient
(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'rs 'replace-string)
(defalias 'lcd 'list-colors-display)
(defalias 'ds 'desktop-save)

(defalias 'dsm 'desktop-save-mode)
(defalias 'elm 'emacs-lisp-mode)
(defalias 'hm 'html-mode)
(defalias 'jsm 'js-mode)
(defalias 'fm 'fundamental-mode)
(defalias 'ssm 'shell-script-mode)
(defalias 'om 'org-mode)

(defalias 'ms 'magit-status)
(defalias 'xnp 'xah-new-page)
(defalias 'xfc 'xah-find-count)
(defalias 'xcm 'xah-css-mode)
(defalias 'xem 'xah-elisp-mode)
(defalias 'xhm 'xah-html-mode)
(defalias 'xjm 'xah-js-mode)
(defalias 'xcm 'xah-clojure-mode)

;; no want tpu-edt
(defalias 'tpu-edt 'forward-char)
(defalias 'tpu-edt-on 'forward-char)

;; HHH___________________________________________________________________
(progn
  ;; org-mode
  ;; make “org-mode” syntax color code sections
  (setq org-src-fontify-natively t)
  (setq org-startup-folded nil)
  (setq org-return-follows-link t)
  (setq org-startup-truncated nil))

;; HHH___________________________________________________________________

(when (fboundp 'eww)
  (defun xah-rename-eww-buffer ()
        "Rename `eww-mode' buffer so sites open in new page.
URL `http://ergoemacs.org/emacs/emacs_eww_web_browser.html'
Version 2017-11-10"
	(let (($title (plist-get eww-data :title)))
	  (when (eq major-mode 'eww-mode )
	    (if $title
		(rename-buffer (concat "eww " $title ) t)
	      (rename-buffer "eww" t)))))

    (add-hook 'eww-after-render-hook 'xah-rename-eww-buffer))

;; load theme
(use-package seti-theme
  :ensure t)
(load-theme 'seti t)

(setq inhibit-startup-screen t)
;; don't show menual-bar
(menu-bar-mode -1)
(use-package which-key
  :ensure t
  :config
  (which-key-mode t)
)

(if (display-graphic-p)
    (setq initial-frame-alist
          '(
            (tool-bar-lines . 0)
            (background-color . "honeydew")
            (width . 106)
            (height . 56)
            ;; (left . 50)
            ;; (top . 50)
            ))
  (setq initial-frame-alist '( (tool-bar-lines . 0))))

;; (setq default-frame-alist
;;       '(
;;         (tool-bar-lines . 0)
;;         (background-color . "honeydew")
;;         (width . 100)
;;         (height . 55)))


(defun xah-save-all-unsaved ()
  "Save all unsaved files. no ask.
Version 2019-11-05"
  (interactive)
  (save-some-buffers t))

;; ---------- mine ----------
;; fix projectile string-trim
(require 'subr-x)
;; (setq shell-command-switch "-ic")

(eval-when-compile
 ;; Following line is not needed if use-package.el is in ~/.emacs.d
 ;; (add-to-list 'load-path "/Users/HeBee/PersonalData/.emacs.d/elpa/use-package-20200721.2156")
 (require 'use-package))

;; load others files
(load (xah-get-fullpath "lisp/init-evil.el"))
(load (xah-get-fullpath "lisp/init-company.el"))
(load (xah-get-fullpath "lisp/company-sql-tool/company-sql.el"))
(load (xah-get-fullpath "lisp/company-sql-tool/sql-def.el"))
(load (xah-get-fullpath "lisp/init-common.el"))
(load (xah-get-fullpath "lisp/init-python.el"))
(load (xah-get-fullpath "lisp/init-lsp.el"))
(load (xah-get-fullpath "lisp/init-sql.el"))
(load (xah-get-fullpath "lisp/init-dbconn.el"))
(load (xah-get-fullpath "lisp/init-projectile.el"))
(load (xah-get-fullpath "lisp/init-windows.el"))
(load (xah-get-fullpath "lisp/init-ivy.el"))
(load (xah-get-fullpath "lisp/init-magit.el"))
(load (xah-get-fullpath "lisp/init-eww.el"))
(load (xah-get-fullpath "lisp/init-docker.el"))

;; auto load function
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(require 'company)
(require 'company-sql)
(add-hook 'after-init-hook 'global-company-mode)
;; (add-hook 'emacs-startup-hook 'persp-state-load)

(autoload 'sql-def-buffer-create-for-name-at-point "sql-def")
;; (message (file-name-directory (or load-file-name buffer-file-name)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("1f6039038366e50129643d6a0dc67d1c34c70cdbe998e8c30dc4c6889ea7e3db" "2f08b4f5ff619bdfa46037553ea41f72f09013a2e6b7287799db6cec6a7dddb2" "c48551a5fb7b9fc019bf3f61ebf14cf7c9cdca79bcb2a4219195371c02268f11" default))
 '(eww-search-prefix "https://bing.com/search?q=")
 '(minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt))
 '(package-selected-packages
   '(docker scala-mode json-mode flycheck pyenv-mode treemacs seti-theme diminish lsp-ui melancholy-theme sublime-themes lsp-ivy lsp-mode zoom-window perspective yasnippet-classic-snippets evil-terminal-cursor-changer which-key command-log-mode use-package toml-mode sqlformat projectile markdown-mode ivy-rich evil counsel company-quickhelp company-anaconda color-theme amx))
 '(warning-suppress-types '((perspective)))
 '(zoom-window-mode-line-color "black"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(font-lock-keyword-face ((t nil))))

   ;; '(sublime-themes lsp-ivy lsp-mode zoom-window perspective yasnippet-classic-snippets evil-terminal-cursor-changer which-key command-log-mode use-package toml-mode sqlformat projectile markdown-mode ivy-rich ivy-hydra evil counsel company-quickhelp company-anaconda color-theme amx))
