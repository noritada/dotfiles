
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (graphql-mode ddskk po-mode zenburn-theme rust-mode ##))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'zenburn t)
(setq-default require-final-newline nil)
(global-set-key (kbd "C-x C-j") 'skk-mode)

(setq initial-frame-alist
      (append (list
	       ;; location
	       '(top . 0)
	       '(left . 0)
	       ;; size
	       '(width . 100)
	       '(height . 55))
	      initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

;; workaround for an issue that "/" is used both as default-directory
;; and as command-line-default-directory
(setq-default command-line-default-directory "~/")

;; key bindings
(global-set-key "\C-x\C-b" 'ibuffer)
