(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(require 'package)
(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

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
   ;; ("TAB" . 'ivy-alt-done)
   ("M-y" . counsel-yank-pop)
   (:map ivy-minibuffer-map
	 ("TAB" . 'ivy-alt-done)))
  :config
  (ivy-mode 1)
  (setq ivy-height 10
	ivy-use-virtual-buffers t
	ivy-display-style 'fancy
	ivy-initial-inputs-alist nil
  ;; (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-alt-done)
  counsel-rg-base-command
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

(defun then_R_operator ()
  "R - %>% operator or 'then' pipe operator"
  (interactive)
  (just-one-space 1)
  (insert "%>%")
  (reindent-then-newline-and-indent))

(defun then_ggplot_plus ()
  (interactive)
  (just-one-space 1)
  (insert "+")
  (reindent-then-newline-and-indent))

(defun forbid-vertical-split ()
  "Only permit horizontal window splits."
  (setq-local split-height-threshold nil)
  (setq-local split-width-threshold 0))

(use-package ess
  :ensure t
  :hook (ess-mode-hook . forbid-vertical-split)
  :init (require 'ess-site)
  :config
  (setq ess-ask-for-ess-directory nil
	ess-local-process-name "R"
	ansi-color-for-comint-mode 'filter
	comint-scroll-to-bottom-on-input t
	comint-scroll-to-bottom-on-output t
	comint-move-point-for-output t
	ess-eval-visibly-p t
	ess-eval-visibly 'nowait
	ess-default-style 'RStudio
	fill-column 72
	comment-auto-fill-only-comments t)
  (auto-fill-mode t)
  :bind (:map ess-mode-map
	      ("C-<return>" . 'then_R_operator)
	      ("M-<return>" . 'then_ggplot_plus)
	      ("_" . 'ess-insert-assign)
	      ("S-<return>" . 'ess-eval-region-or-function-or-paragraph-and-step)
         :map inferior-ess-r-mode-map
	      ("C-<return>" . 'then_R_operator)
	      ("M-<return>" . 'then_ggplot_plus)
	      ("_" . 'ess-insert-assign))
  	      ("S-<return>" . 'ess-eval-region-or-function-or-paragraph-and-step))

(use-package yaml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

(use-package projectile
  :ensure t
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (setq projectile-completion-system 'ivy
	projectile-project-search-path '("~/Dropbox/")
	projectile-enable-caching t)
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

(use-package pyvenv
  :ensure t
  :init
  (setenv "WORKON_HOME" "~/anaconda3/envs/"))

;; (use-package company
;;   :ensure t
;;   :config
;;   (setq company-idle-delay 0)
;;   (setq company-minimum-prefix-length 1))

;; (use-package lsp-mode
;;   :ensure t
;;   :hook (python-mode . lsp-deferred)
;;   :commands (lsp lsp-deferred))

;; (use-package company-lsp
;;   :ensure t
;;   :config
;;   (push 'company-lsp company-backends))

;; (use-package lsp-ui
;;   :ensure t
;;   :hook (lsp-mode . lsp-ui-mode))
