(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
;;initial-config
(setq make-backup-files nil)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(column-number-mode t)
(setq inhibit-splash-screen t)
(setq column-number-mode t)
(setq-default tab-width 2)
(global-set-key (kbd "RET") 'newline-and-indent)
(electric-pair-mode 1)
(global-auto-revert-mode 1)
(set-fringe-mode '(10 . 0)) ;; Show a nice fringe
;; CUSTOM THEME
(add-to-list 'custom-theme-load-path "~/.emacs.d/custom-themes/")
(load-theme 'planet t)
;; nyan mode
(require 'nyan-mode)
(nyan-mode 1)
(setq nyan-wavy-trail t)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html.erb?\\'" . web-mode))
(add-hook 'ruby-mode-hook 'eldoc-mode)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'css-mode-hook 'emmet-mode) ;; enable Emmet's css
(add-hook 'web-mode-hook 'emmet-mode) ;; enable Emmet's css
(require 'ido)
(ido-mode 1)
;; Display results vertically
(require 'ido-vertical-mode)
(ido-vertical-mode 1)
(require 'yasnippet)
(yas-global-mode 1)
;;;ARDUINO-MODE
(require 'arduino-mode)
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)
;;;php-mode
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
;;;;;BEGINNING OF A LINE, SMARTER
(defun smarter-move-beginning-of-line (arg)
"Move point back to indentation of beginning of line.
Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.
If ARG is not nil or 1, move forward ARG - 1 lines first. If
point reaches the beginning or end of the buffer, stop there."
(interactive "^p")
(setq arg (or arg 1))
;; Move lines first
(when (/= arg 1)
(let ((line-move-visual nil))
(forward-line (1- arg))))
(let ((orig-point (point)))
(back-to-indentation)
(when (= orig-point (point))
(move-beginning-of-line 1))))
;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
'smarter-move-beginning-of-line)
