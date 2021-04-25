;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;;; Code:

(setq org-agenda-files '("~/Agenda"))

(setq vc-handled-backends (delq 'Git vc-handled-backends))


;; boogie-friends setup https://github.com/boogie-org/boogie-friends
(setq flycheck-dafny-executable "~/bin/dafny/dafny")
(setq flycheck-inferior-dafny-executable "~/bin/dafny/dafny-server") ;; Optional


(global-set-key (kbd "C-x a r") 'align-regexp)

(require 'flycheck)
(flycheck-add-next-checker 'typescript-tslint 'javascript-eslint)

(use-package! flycheck
  :config
  (setq-default flycheck-disabled-checkers '(haskell-stack-ghc haskell-ghc)))

(use-package! flycheck-haskell
  :config
  (add-hook 'haskell-mode-hook #'flycheck-haskell-setup))

(use-package! ormolu
 :hook (haskell-mode . ormolu-format-on-save-mode)
 :bind
 (:map haskell-mode-map
   ("C-c r" . ormolu-format-buffer)))

(use-package! eglot
  :config
  (add-to-list 'eglot-server-programs '(haskell-mode . ("ghcide" "--lsp"))))

;; python linters setup

(custom-set-variables
 '(flycheck-python-flake8-executable "python3")
 '(flycheck-python-pycompile-executable "python3")
 '(flycheck-python-pylint-executable "python3"))

;; (load-theme 'doom-challenger-deep)

(defun random-theme ()
  (let*
    ((i (random (length (custom-available-themes))))
     (theme (nth i (custom-available-themes))))
  (load-theme theme t)))
(random-theme)

;;

(use-package! toml-mode)

(use-package! rust-mode)

(use-package! flycheck-rust
  :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(setq rustic-flycheck-clippy-params "--message-format=json")

;; to export source code blocks in org mode as listings instead of verbatim

(require 'org)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (latex . t)))

;; (setq org-src-fontify-natively t)
;; (setq org-latex-listings t)
;; (add-to-list 'org-latex-packages-alist '("" "listings"))
;; (add-to-list 'org-latex-packages-alist '("" "color"))

(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(set-frame-font "Inconsolata-12")
