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
;; }}}

;; leaf-related packages {{{
(leaf leaf-convert :ensure t)
(leaf leaf-tree
  :ensure t
  :custom ((imenu-list-size . 30)
           (imenu-list-position . 'left)))
;; }}}

;; Major mode packages {{{
(leaf graphql-mode :ensure t)
(leaf po-mode :ensure t)
(leaf review-mode :ensure t)
(leaf rust-mode :ensure t)
;; }}}

;; Other packages {{{
(leaf skk
  :ensure ddskk
  :require t skk-study skk-hint
  :bind (("C-x C-j" . skk-mode)))
;; }}}

(provide 'init)
;; vim:foldmethod=marker:foldlevel=0
