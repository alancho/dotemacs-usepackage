(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(require 'package)
(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(setq custom-file "~/.emacs.d/custom-file.el")
(load-file custom-file)

(setq inhibit-startup-message t)

(set-face-attribute 'default nil :height 105 :family "monospace" :weight 'normal :width 'normal)

(load-theme 'tango-dark)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(display-time-mode 1)
(delete-selection-mode 1)
(show-paren-mode 1)
(electric-pair-mode 1)
(visual-line-mode 1)
(global-linum-mode 1)

;; Mis preferencias visuales
(setq shift-select-mode t
      transient-mark-mode t
      auto-save-default nil
      visible-bell t
      prefer-coding-system 'utf-8
      column-number-mode t
      redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1
      ring-bell-function #'ignore)

;; Desactivar overwrite mode por favor
(define-key global-map [(insert)] nil)

(setq-default line-spacing 1)
(set-default 'truncate-lines t)

(defalias 'yes-or-no-p 'y-or-n-p)

(use-package ivy
  :diminish (ivy-mode . "")
  :bind (:map ivy-mode-map
              ("C-'" . ivy-avy))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 15)
  (setq ivy-count-format "")
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-re-builders-alist
        '((ivy-switch-buffer . ivy--regex-fuzzy)
          (counsel-find-file . ivy--regex-plus)
          (counsel-locate . ivy--regex-plus)
          (counsel-M-x . ivy--regex-plus)
          (t . ivy--regex-plus))))

(use-package counsel
  :ensure t
  :demand t
  :bind*
  (("C-c C-r" . ivy-resume)
   ("C-x b" . ivy-switch-buffer)
   ("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("C-x C-d" . counsel-rg)
   ("C-x C-r" . counsel-recentf)
   ("C-x C-l" . counsel-locate)
   ("M-y" . counsel-yank-pop))
  :config
  (ivy-mode 1)
  (setq ivy-height 10)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy)
  (setq ivy-initial-inputs-alist nil)
  (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-alt-done)
  (setq counsel-rg-base-command
	"rg -i -M 120 --no-heading --line-number %s . -tr /home/alancho/"))

(use-package swiper
  :ensure t
  :bind*
  (("C-s" . swiper)
   ("C-r" . swiper)
   ("C-M-s" . swiper-all)))

(use-package avy
  :ensure t
  :bind* (("C-'" . avy-goto-char)
          ("C-," . avy-goto-char-2))
  :config
  (setq avy-keys '(?h ?t ?n ?s)))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package ess
  :ensure t
  :init (require 'ess-site)
  :config
  (setq ess-ask-for-ess-directory nil)
  (setq ess-local-process-name "R")
  (setq ansi-color-for-comint-mode 'filter)
  (setq comint-scroll-to-bottom-on-input t)
  (setq comint-scroll-to-bottom-on-output t)
  (setq comint-move-point-for-output t)
  (setq ess-eval-visibly-p nil)
  (setq ess-eval-visibly 'nowait)
  (setq ess-default-style 'RStudio)
  (setq fill-column 72)
  (setq comment-auto-fill-only-comments t)
  (auto-fill-mode t))

(use-package yaml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

(use-package projectile
  :ensure t
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (setq projectile-completion-system 'ivy)
  (setq projectile-enable-caching t)
  (projectile-mode))

(use-package writeroom-mode
  :ensure t
  :config
  (setq writeroom-width 120))

(use-package poly-markdown
  :ensure t)

(use-package poly-R
  :ensure t)

(use-package polymode
  :ensure t
  :init
  (require 'polymode)
  (require 'poly-markdown)
  (require 'poly-R)
  :config
  (add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode)))
