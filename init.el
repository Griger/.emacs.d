
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
(load "~/.emacs.d/fira.el")
(load "~/.emacs.d/pretty.el") 

(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 110
                    :weight 'normal
                    :width 'normal)

;;Set tab-size
(setq-default tab-width 4)

;;Turn on powerline
;;(require 'powerline)
;;(powerline-default-theme)

(require 'all-the-icons)
(load "~/.emacs.d/doom.el")
 
;;Turn on doom-modeline

(require 'doom-modeline)
(load "~/.emacs.d/doom-modeline.el")
(doom-modeline-mode 1)

;;Start rainbow-delimiters-mode in most programming modes:
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;Start rainbow-delimiters-mode in Latex-mode:
(add-hook 'LaTeX-mode-hook #'rainbow-delimiters-mode)

;;Cambiar entre buffers con el tabulador
(global-set-key [C-tab] 'next-buffer)
(global-set-key [C-iso-lefttab] 'previous-buffer)

;;Que el minor-mode para mostrar el numero de linea se active automaticamente en cada buffer.
(global-linum-mode 1)

;;Ocultar la barra de herramientas.
(tool-bar-mode -1)
(menu-bar-mode -1)

;;Abrir los archivos PHP siempre con el web-mode
(add-hook 'web-mode-hook 'emmet-mode)
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(add-hook 'css-mode-hook 'emmet-mode)

;;Abrir los archivo tkiz siempre con latex-mode
(add-to-list 'auto-mode-alist '("\\.tikz\\'" . latex-mode))

;;Abrir los archivos .h con c++-mode.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

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
;;(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
(setq reftex-plug-into-auctex t)

;;Hacer que no se tabulen los docstrings en Python
(require 'python)
(defun my-python-indent-line ()
  (if (eq (car (python-indent-context)) :inside-docstring)
      'noindent
    (python-indent-line)))

(add-hook 'python-mode-hook
		  (lambda ()
			(setq flycheck-pylintrc "~/.emacs.d/.pylintrc")
			(setq indent-line-function #'my-python-indent-line)
			)
		  )

;;Activar los atajos para moverse entre ventanas.
(windmove-default-keybindings)

;;move-text
(move-text-default-bindings)

;;Multi-cursor
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

;;company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(eval-after-load 'company
  '(add-to-list 'company-backends '(company-css company-web-html)))

;;Hacer que el diccionario por defecto de ispell sea el inglés
(require 'ispell)
(setq ispell-dictionary "en")

;;languagetool config
(require 'langtool)
(setf langtool-language-tool-jar "/usr/share/java/languagetool/languagetool-commandline.jar"
langtool-java-bin "/usr/bin/java"
langtool-java-classpath "/usr/share/languagetool:/usr/share/java/languagetool/*"
langtool-mother-tongue "es")

;;c++-mode config
(require 'fic-mode)
(add-hook 'prog-mode-hook 'fic-mode)
(set-face-attribute 'fic-face nil :foreground "white" :background "#4C566A")

;;configuration of lsp
(require 'lsp-mode)
(add-hook 'prog-mode-hook #'lsp-deferred)

(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(add-hook 'prog-mode-hook 'flycheck-mode)

(require 'company-lsp)
(push 'company-lsp company-backends)

(require 'yasnippet)
(yas-global-mode 1)
