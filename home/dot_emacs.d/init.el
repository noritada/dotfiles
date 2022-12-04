;; leaf installation code {{{
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; }}}

;; Emacs built-in packages {{{
(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

(leaf cus-start
  :doc "define customization properties of builtins"
  :tag "builtin" "internal"

  :bind (("C-x C-b" . ibuffer))
  :custom '((default-frame-alist .
	      '((top . 0)
		(left . 0)
		(width . 100)
		(height . 55)))))

(leaf files
  :doc "file input and output commands for Emacs"
  :tag "builtin"
  :custom (require-final-newline . nil))

(leaf startup
  :doc "process Emacs shell arguments"
  :tag "builtin"
  :custom
  ;; workaround for an issue that "/" is used both as default-directory
  ;; and as command-line-default-directory
  (command-line-default-directory . "~/"))
;; }}}

;; leaf-related packages {{{
(leaf leaf-convert :ensure t)

(leaf leaf-tree
  :ensure t
  :custom ((imenu-list-size . 30)
           (imenu-list-position . 'left)))
;; }}}

;; Major mode packages {{{
(leaf adoc-mode :ensure t)
(leaf dockerfile-mode :ensure t)
(leaf graphql-mode :ensure t)
(leaf po-mode :ensure t)
(leaf review-mode :ensure t)
(leaf rust-mode :ensure t)
;; }}}

;; ivy-related packages {{{
(leaf ivy
  :doc "Incremental Vertical completYon"
  :req "emacs-24.5"
  :tag "matching" "emacs>=24.5"
  :url "https://github.com/abo-abo/swiper"
  :emacs>= 24.5
  :ensure t
  :blackout t
  :leaf-defer nil
  :custom ((ivy-initial-inputs-alist . nil)
           (ivy-re-builders-alist . '((t . ivy--regex-fuzzy)
                                      (swiper . ivy--regex-plus)))
           (ivy-use-selectable-prompt . t))
  :global-minor-mode t
  :config
  (leaf swiper
    :doc "Isearch with an overview. Oh, man!"
    :req "emacs-24.5" "ivy-0.13.0"
    :tag "matching" "emacs>=24.5"
    :url "https://github.com/abo-abo/swiper"
    :emacs>= 24.5
    :ensure t
    :bind (("C-s" . swiper)))

  (leaf counsel
    :doc "Various completion functions using Ivy"
    :req "emacs-24.5" "swiper-0.13.0"
    :tag "tools" "matching" "convenience" "emacs>=24.5"
    :url "https://github.com/abo-abo/swiper"
    :emacs>= 24.5
    :ensure t
    :blackout t
    :bind (("C-S-s" . counsel-imenu)
           ("C-x C-r" . counsel-recentf))
    :custom `((counsel-yank-pop-separator . "\n----------\n")
              (counsel-find-file-ignore-regexp . ,(rx-to-string '(or "./" "../") 'no-group)))
    :global-minor-mode t))

(leaf ivy-rich
  :doc "More friendly display transformer for ivy."
  :req "emacs-24.5" "ivy-0.8.0"
  :tag "ivy" "emacs>=24.5"
  :emacs>= 24.5
  :ensure t
  :after ivy
  :global-minor-mode t)

(leaf prescient
  :doc "Better sorting and filtering"
  :req "emacs-25.1"
  :tag "extensions" "emacs>=25.1"
  :url "https://github.com/raxod502/prescient.el"
  :emacs>= 25.1
  :ensure t
  :commands (prescient-persist-mode)
  :custom `((prescient-aggressive-file-save . t)
            (prescient-save-file . ,(locate-user-emacs-file "prescient")))
  :global-minor-mode prescient-persist-mode)

(leaf ivy-prescient
  :doc "prescient.el + Ivy"
  :req "emacs-25.1" "prescient-4.0" "ivy-0.11.0"
  :tag "extensions" "emacs>=25.1"
  :url "https://github.com/raxod502/prescient.el"
  :emacs>= 25.1
  :ensure t
  :after prescient ivy
  :custom ((ivy-prescient-retain-classic-highlighting . t))
  :global-minor-mode t)
;; }}}

;; company-related packages {{{
(leaf company
  :doc "Modular text completion framework"
  :req "emacs-25.1"
  :emacs>= 25.1
  :ensure t
  :blackout t
  :defvar company-backends
  :bind ((company-active-map
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous))
         (company-search-map
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)))
  :custom ((company-require-match . 'never)
           (company-idle-delay . 0)
           (company-minimum-prefix-length . 2)
           (company-selection-wrap-around . t)
           (company-tooltip-align-annotations . t)
           (company-backends '())))

(leaf company-dict
  :doc "A backend that emulates ac-source-dictionary"
  :req "emacs-24.4"
  :emacs>= 24.4
  :ensure t
  :after company
  :config (add-to-list 'company-backends 'company-dict))
;; }}}

;; Other packages {{{
(leaf skk
  :ensure ddskk
  :require t skk-study skk-hint
  :bind (("C-x C-j" . skk-mode)))

(leaf zenburn-theme
  :ensure t
  :config (load-theme 'zenburn t))
;; }}}

;; Other configurations {{{
(unless (version< emacs-version "28.0")
    ;; avoid the aenkaku space underline issue
    (setq nobreak-char-display nil))
(desktop-save-mode 1)
;; }}}

(provide 'init)
;; vim:foldmethod=marker:foldlevel=0
