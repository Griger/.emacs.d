
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;;Turn on powerline
(require 'powerline)
(powerline-default-theme)


;;Cambiar entre buffers con el tabulador
(global-set-key [C-tab] 'next-buffer)
(global-set-key [C-iso-lefttab] 'previous-buffer)

;;Que el minor-mode para mostrar el numero de linea se active automaticamente en cada buffer.
(global-linum-mode 1)

;;Ocultar la barra de herramientas.
(tool-bar-mode -1)
(menu-bar-mode -1)

;;Abrir los archivos PHP siempre con el web-mode
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))

;;Que AucTex nos pregunte cual el archivo maestro.
(setq-default TeX-master nil)

;;Atajo de teclado para insertar salto de linea en AucTex
(defun insertarSaltoLinea ()
  (interactive)
  (insert "\\\\")
  (end-of-line)
  (newline-and-indent)
  (newline-and-indent)
)

(eval-after-load "latex"
  '(define-key LaTeX-mode-map (kbd "<s-return>") #'insertarSaltoLinea))

;;Habilitar Reftex y CDLatex al iniar AucTex
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-flyspell) ;;activar FlySpell al abrir un archivo Tex
(setq reftex-plug-into-auctex t)

;;Hacer que no se tabulen los docstrings en Python
(require 'python)
(defun my-python-indent-line ()
  (if (eq (car (python-indent-context)) :inside-docstring)
      'noindent
    (python-indent-line)))

(defun my-python-mode-hook ()
  (setq indent-line-function #'my-python-indent-line))
(add-hook 'python-mode-hook #'my-python-mode-hook)

;;Activar los atajos para moverse entre ventanas.
(windmove-default-keybindings)

;;Multi-cursor
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

;;Hacer que el diccionario por defecto de ispell sea el inglés
(require 'ispell)
(setq ispell-dictionary "en")
