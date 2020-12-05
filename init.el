(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(require 'package)
(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(setq custom-file "~/.emacs.d/custom-file.el")
(load-file custom-file)

(setq inhibit-startup-message t)

(set-face-attribute 'default nil :height 105 :family "monospace" :weight 'normal :width 'normal)

(display-time-mode 1)
(delete-selection-mode 1)
(setq shift-select-mode t)
(transient-mark-mode t)
(setq-default line-spacing 1)
(setq auto-save-default nil)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)
(electric-pair-mode 1)
(visual-line-mode 1)
(setq visible-bell t)
(prefer-coding-system 'utf-8)
(setq column-number-mode t)

(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

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
          (t   . ivy--regex-plus))))

(use-package counsel
  :ensure t
  :demand t
  :bind*
  (("C-c C-r" . ivy-resume)
   ("C-x b" . ivy-switch-buffer)
   ("M-x" . counsel-M-x)
   ;; ("C-M-i" . counsel-imenu)
   ("C-x C-f" . counsel-find-file)
   ;; ("C-c d" . counsel-dired-jump)
   ;; ("C-c j" . counsel-git-grep)
   ;; ("C-x C-d" . counsel-ag)
   ("C-x C-d" . counsel-rg)
   ("C-x C-r" . counsel-recentf)
   ("C-x C-l" . counsel-locate)
   ("M-y" . counsel-yank-pop))
  :config
  (ivy-mode 1)
  (setq ivy-height 10)
  ;; (setq counsel-find-file-at-point t)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy)
  (setq ivy-initial-inputs-alist nil)
  (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-alt-done))

(use-package swiper
  :ensure t
  :bind*
  (("C-s" . swiper)
   ("C-r" . swiper)
   ("C-M-s" . swiper-all))
  :bind
  (:map read-expression-map
        ("C-r" . counsel-expression-history)))

(use-package avy
  :ensure t
  :bind* (("C-'" . avy-goto-char)
          ("C-," . avy-goto-char-2))
  :config
  (setq avy-keys '(?h ?t ?n ?s)))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))
