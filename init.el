;;; init.el -*- lexical-binding: t; -*-

(setq comp-async-jobs-number 8)
(doom! :completion company
       (ivy +fuzzy +prescient)
       :ui deft doom doom-quit hl-todo hydra nav-flash ophints
       (popup +all +defaults)
       unicode vc-gutter window-select workspaces zen
       :editor (evil +everywhere)
       file-templates fold format multiple-cursors rotate-text snippets
       :emacs dired electric ibuffer
       (undo +tree)
       :tools (eval +overlay)
       (lookup +dictionary +offline +docsets)
       (lsp +eglot)
       magit make pdf rgb
       :lang (cc +lsp)
       common-lisp coq data emacs-lisp
       (haskell +dante)
       java javascript latex lua markdown nix
       (org +dragndrop +pandoc)
       python racket rust scheme sh web yaml
       :app calendar
       :checkers (syntax +childframe) grammar
       :config (default +bindings +smartparens)
       :custom dired-sidebar rss
       :customized doom-dashboard
       (modeline +light)
       :legacy (flyspell +hunspell))
