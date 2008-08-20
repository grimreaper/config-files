;; ;; Actual jshea customizations
(defalias 'yes-or-no-p 'y-or-n-p)

(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")

(setq debug-on-error t
      ido-everywhere t
      user-full-name    "Jon Shea"
      frame-title-format '(buffer-file-name "%f" ("%b"))
      change-log-default-name "ChangeLog"
      inhibit-startup-message t
      require-final-newline 't
      search-highlight t
      display-time-24hr-format t
      tab-always-indent t
      make-backup-files nil
      indent-tabs-mode nil
      query-replace-highlight t
      tramp-default-method "scp"
      mac-option-modifier 'meta
;;      longlines-show-hard-newlines t
      longlines-auto-wrap t
      scroll-step 1)
(setq-default indent-tabs-mode nil
              	      save-place t)

(when (boundp 'aquamacs-version)

(require 'cl)
;;mostly just use one buffer
(one-buffer-one-frame-mode 0)

;;sometimes I want a new window
(defun my-new-frame ()
  (interactive)
  (let ((one-buffer-one-frame t))
    (new-frame)))
(define-key osx-key-mode-map (kbd "A-n") 'my-new-frame)
;;sometimes

(defun my-close-current-window-asktosave ()
  (interactive)
  (let ((one-buffer-one-frame t))
    (close-current-window-asktosave)))
(define-key osx-key-mode-map (kbd "A-w") 'my-close-current-window-asktosave)

(define-key osx-key-mode-map (kbd "M-[") "“")
(define-key osx-key-mode-map (kbd "M-{") "”")
(define-key osx-key-mode-map (kbd "M-]") "‘")
(define-key osx-key-mode-map (kbd "M-}") "’")
(define-key osx-key-mode-map (kbd "M--") "–")
(define-key osx-key-mode-map (kbd "M-_") "—")

(server-start)
;; don't warn about killing buffers opened by emacs-client
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))


(add-to-list 'load-path "/Users/jonshea/emacs/elisp")
(autoload 'whizzytex-mode "/Users/jonshea/emacs/whizzytex/whizzytex" 
          "WhizzyTeX, a minor-mode WYSIWYG environment for LaTeX" t) 


(require 'ido) ;; Improved file selection and buffer switching
(ido-mode t)
(require 'smooth-scrolling)
;; (require 'htmlize) ;; Makes .html files from syntax highlighted buffers

;; ;; Hooks from Clementson probably
(add-hook 'html-mode-hook
          (lambda ()
 	    (nxml-mode)
 	    (rng-auto-set-schema)
 	    (rng-validate-mode)
 	    (message "My html-mode customizations loaded")))
(add-hook 'nxml-mode-hook
 	  (lambda ()
            ;; (longlines-mode)
 	    (define-key nxml-mode-map "\r" 'newline-and-indent)
 	    (setq indent-tabs-mode nil)
            ;; (setq local-abbrev-table nxml-mode-abbrev-table)
 	    (message "My nxml-mode customizations loaded")))

(setq-default nxml-sexp-element-flag t) ;Treat elements like S-expressions!

(setq-default nxml-slash-auto-complete-flag t) ; type </ it will fill out the rest.
;; I'm going nuts here trying to make Aquamacs forget about html-mode, and only us nxml mode.
(rassq-delete-all 'html-helper-mode magic-mode-alist)
(rassq-delete-all 'html-mode auto-mode-alist)
(add-to-list 'auto-mode-alist '("\\.\\(rhtml\\|xhtml\\|html\\)$" . nxml-mode))
(add-to-list 'magic-mode-alist '("\\.\\(rhtml\\|xhtml\\|html\\)$" . nxml-mode))

(put 'nxml-mode 'flyspell-mode-predicate 'sgml-mode-flyspell-verify) 

;; ;; ;; duplicate buffers easier to spot
(require 'uniquify)
(setq-default uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq ispell-program-name "/opt/local/bin/ispell")

(longlines-mode)
(add-hook 'text-mode-hook 'longlines-mode)

(line-number-mode 1)
(display-time)
(global-font-lock-mode t)
(show-paren-mode 1)
(tool-bar-mode -1)
(mouse-wheel-mode t)
(line-number-mode 1)
(column-number-mode 1)
(auto-insert-mode t)
;;(autoload 'flyspell-mode "flyspell" "On-the-fly spell checker." t)
;;(add-hook 'text-mode-hook (lambda () (auto-fill-mode 1)))
(add-hook 'text-mode-hook 'flyspell-mode)
(global-set-key '[(f5)] 'call-last-kbd-macro)
(global-set-key (kbd "C-j") 'flyspell-check-previous-highlighted-word)
(global-set-key (kbd "C-c j") 'flyspell-check-previous-highlighted-word)
(global-set-key '[(f8)] 'flyspell-check-previous-highlighted-word)
(global-set-key (kbd "C-l") 'goto-line)
(global-set-key (kbd "C-;") 'comment-region)
(global-set-key (kbd "C-:") 'uncomment-region)
;;(global-set-key (kbd "A-w") 'nil)
;;(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)


(add-to-list 'load-path
	     "~/emacs/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/emacs/yasnippet/snippets/")


(load-library "paren")

;; (defadvice longlines-mode-on (around longlines-folding activate)
;;   "Do the right then when `folding-mode' is active."
;;   (let ((refold (and (boundp 'folding-mode)
;;                      folding-mode)))
;;     (when refold
;;       (folding-mode -1))
;;     ad-do-it
;;     (when refold
;;       (folding-mode 1))))


;; (add-hook 'LaTeX-mode-hook (lambda ()
;; 			     (TeX-fold-mode 1)))
;; (autoload 'whizzytex-mode
;;   "whizzytex"
;;   "WhizzyTeX, a minor-mode WYSIWIG environment for LaTeX" t)

(setq TeX-newline-function 'newline-and-indent)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode) 


;; ;(require 'paredit)
;; ;(require 'color-theme)

;; (setq sbcl-path "/sw/bin/sbcl")

;; (setenv "SBCL_HOME" "/usr/local/lib/sbcl/") ; needed for SBCL
;; (setq lisp-sbcl     "/usr/local/bin/sbcl")
;; (setq inferior-lisp-program sbcl-path)


;; ;; (setenv "SBCL_HOME" "/usr/local/lib/sbcl/") ; needed for SBCL
;; ;; (setq lisp-sbcl     "/usr/local/bin/sbcl")
;; ;; (setq inferior-lisp-program "/usr/local/bin/sbcl")

;; (add-to-list 'load-path "~/emacs/slime")

;; (require 'slime)
;; (setq common-lisp-hyperspec-root
;;       "file:///Users/jonshea/emacs/HyperSpec/")
;; (setq browse-url-browser-function 'browse-url-default-macosx-browser)
;; ;; (setq slime-lisp-implementations
;; ;;       '((sbcl ("/usr/locol/bin/sbcl"))))  ; default
;; (setq slime-edit-definition-fallback-function 'find-tag)
;; (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
;;  (slime-setup :autodoc t)
;; ;; (global-set-key "\C-cs" 'slime-selector)

;; ;; (defun slime-sbcl ()
;; ;;   (interactive)
;; ;;   (apply #'slime-start
;; ;;          (list* :buffer "*inferior-lisp-sbcl*" 
;; ;;                 (slime-lookup-lisp-implementation slime-lisp-implementations
;; ;;                                                   'sbcl))))

;; ;; ;(define-key global-map [f9] 'compile)

;; ;; (setq ispell-extra-args '("--sug-mode=ultra"))



(setq-default whizzy-viewers '(("-skim" "skim")))

;; ;; ;; ;;;;;End TeX
;; ;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; ;; ;;;; Begin Octave

;; ;(require 'octave-mode)
;; ;(autoload 'octave-mode "octave-mod" nil t) ; turn on Octave mode
;; (setq auto-mode-alist
;;         (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; (add-hook 'inferior-octave-mode-hook
;; 	  (lambda ()
;; 	    (define-key inferior-octave-mode-map [up]
;; 	      'comint-previous-input)
;; 	    (define-key inferior-octave-mode-map [down]
;; 	      'comint-next-input)
;; 	    ))




;; ;; ;; ;;;;;End Octave
;; ;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; ;; ;;;;;;;Begin IDL


;; ;; (setq idlwave-expand-generic-end t)

;; ;; ;; ;;; Other people's shit
;; (autoload 'idlwave-mode "idlwave" "IDLWAVE Mode" t)
;; (autoload 'idlwave-shell "idlw-shell" "IDLWAVE Shell" t)
;; (setq auto-mode-alist  (cons '("\\.pro\\'" . idlwave-mode) auto-mode-alist))

;; (add-hook 'idlwave-mode-hook
;; 	  (lambda ()
;; 	    (local-set-key "\r" 'idlwave-newline)
;; 	    ;; If my finger wanders up to Escape
;; 	    (local-set-key [?\e?\t] 'idlwave-complete)
;; 	    (setq			 ; Set Options Here
;; 	     ;; Gotta have that smart-continue-indenting
;; 	     idlwave-max-extra-continuation-indent 100
;; 	     idlwave-header-to-beginning-of-file t
;; 	     idlwave-expand-generic-end t
;; 	     idlwave-completion-show-classes 10
;; 	     idlwave-store-inquired-class t
;; 	     idlwave-block-indent 2	     ; Proper Indentation settings
;; 	     idlwave-main-block-indent 0  ;; Any self-respecting programmer indents his main block
;; 	     idlwave-end-offset -2
;; 	     idlwave-continuation-indent 2
;; 	     idlwave-reserved-word-upcase nil ; Don't uppercase reserved words
;; 	     ;font-lock-maximum-decoration 3

;; 	     ;; Ahh, mixed case for nearly everything.	Only upcase keywords.
;; 	     idlwave-completion-case '((routine . preserve)
;; 				       (keyword . upcase)
;; 				       (class . preserve)
;; 				       (method . preserve))
;; 	     idlwave-shell-automatic-start t
;; 	     ;; These are in too many classes, so query for them.
;; 	     idlwave-query-class '((method-default . nil)
;; 				   (keyword-default . nil)
;; 				   ("INIT" . t) 
;; 				   ("CLEANUP" . t)
;; 				   ("SETPROPERTY" .t)
;; 				   ("GETPROPERTY" .t)))
;; ;	    (idlwave-autofill-mode t)
	    


;; 	    ;;setup display colors for font-lock
;; 	    ;(set-face-foreground font-lock-comment-face "FireBrick")
;; 	    ;(set-face-foreground font-lock-string-face	"DarkOrchid")
;; 	    ;(set-face-foreground font-lock-keyword-face "DarkGreen")
;; 	    ;(set-face-foreground font-lock-function-name-face	"Navy")
;; 	    ;(set-face-foreground font-lock-variable-name-face "Magenta")
;; 	    ;(set-face-foreground font-lock-reference-face  "DarkSlateGray")))
;; 	    ))


;; (defun indent-or-expand (arg)
;;   "Either indent according to mode, or expand the word preceding
;; point."
;;   (interactive "*P")
;;   (if (and
;;        (or (bobp) (= ?w (char-syntax (char-before))))
;;        (or (eobp) (not (= ?w (char-syntax (char-after))))))
;;       (dabbrev-expand arg)
;;     (indent-according-to-mode)))

;; (defun my-tab-fix ()
;;   (local-set-key [tab] 'indent-or-expand))
 
;; (add-hook 'c-mode-hook          'my-tab-fix)
;; (add-hook 'sh-mode-hook         'my-tab-fix)
;; (add-hook 'emacs-lisp-mode-hook 'my-tab-fix)

;; (defun iwb ()
;;   "indent whole buffer"
;;   (interactive)
;;   (delete-trailing-whitespace)
;;   (indent-region (point-min) (point-max) nil)
;;   (untabify (point-min) (point-max)))

;; (defun textilize ()
;;   "Convert buffer to html with textile"
;;   (interactive)
;;   (mark-whole-buffer)
;;   (shell-command-on-region (point-min) (point-max) "redcloth" t))

;; ;; ;; Stuff for emacsclient
;; ;; (add-hook 'server-switch-hook
;; ;; 	  (lambda nil
;; ;; 	    (let ((server-buf (current-buffer)))
;; ;; 	      (bury-buffer)
;; ;; 	      (switch-to-buffer-other-frame server-buf))))
;; ;; (custom-set-variables '(server-kill-new-buffers t))
;; ;; (add-hook 'server-done-hook (lambda () (delete-frame))


) ; end Aquamacs specific code
