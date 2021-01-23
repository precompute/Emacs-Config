;;; ~/.doom.d/+config.functions.el -*- lexical-binding: t; -*-

(defun +ivy-display-at-custom-pos (str)
  (ivy-posframe--display str #'+ivy-poshandler-frame-custom))

(defun +ivy-poshandler-frame-custom (info)
  (let ((parent-frame (plist-get info :parent-frame))
        (pos (posframe-poshandler-frame-center info)))
    (cons (car pos)
          (truncate (/ (frame-pixel-height parent-frame) 1.475)))))

(after! calibredb
  (map! ;; :after calibredb-show-mode
      :map calibredb-show-mode-map
      :n "?" #'calibredb-entry-dispatch
      :n "o" #'calibredb-find-file
      :n "O" #'calibredb-find-file-other-frame
      :n "s" #'calibredb-set-metadata-dispatch
      :n "e" #'calibredb-export-dispatch
      :n "q" #'calibredb-entry-quit
      :n "." #'calibredb-open-dired
      "M-t" #'calibredb-set-metadata--tags
      "M-a" #'calibredb-set-metadata--author_sort
      "M-A" #'calibredb-set-metadata--authors
      "M-T" #'calibredb-set-metadata--title
      "M-c" #'calibredb-set-metadata--comments))

(after! calibredb
  (map! :map calibredb-search-mode-map
        [mouse-3] #'calibredb-search-mouse
        [ret]     #'calibredb-find-file
        :n "?"    #'calibredb-dispatch
        :n "a"    #'calibredb-add
        :n "A"    #'calibredb-add-dir
        :n "c"    #'calibredb-clone
        :n "d"    #'calibredb-remove
        :n "j"    #'calibredb-next-entry
        :n "k"    #'calibredb-previous-entry
        :n "l"    #'calibredb-library-list
        :n "n"    #'calibredb-library-next
        :n "p"    #'calibredb-library-previous
        :n "s"    #'calibredb-set-metadata-dispatch
        :n "S"    #'calibredb-switch-library
        :n "o"    #'calibredb-find-file
        :n "O"    #'calibredb-find-file-other-frame
        :n "v"    #'calibredb-view
        :n "."    #'calibredb-open-dired
        :n "b"    #'calibredb-catalog-bib-dispatch
        :n "e"    #'calibredb-export-dispatch
        :n "r"    #'calibredb-search-refresh-and-clear-filter
        :n "R"    #'calibredb-search-refresh-or-resume
        :n "q"    #'calibredb-search-quit
        :n "m"    #'calibredb-mark-and-forward
        :n "f"    #'calibredb-toggle-favorite-at-point
        :n "x"    #'calibredb-toggle-archive-at-point
        :n "h"    #'calibredb-toggle-highlight-at-point
        :n "u"    #'calibredb-unmark-and-forward
        :n "i"    #'calibredb-edit-annotation
        [del]     #'calibredb-unmark-and-backward
        [backtab] #'calibredb-toggle-view
        [tab]     #'calibredb-toggle-view-at-point
        "M-n"     #'calibredb-show-next-entry
        "M-p"     #'calibredb-show-previous-entry
        :n "/"    #'calibredb-search-live-filter
        "M-t"     #'calibredb-set-metadata--tags
        "M-a"     #'calibredb-set-metadata--author_sort
        "M-A"     #'calibredb-set-metadata--authors
        "M-T"     #'calibredb-set-metadata--title
        "M-c"     #'calibredb-set-metadata--comments))

(use-package! lexic
  :after lexic
  :commands lexic-search lexic-list-dictionary
  :config
  (map! :map lexic-mode-map
        :n "q"    #'lexic-return-from-lexic
        :nv "RET" #'lexic-search-word-at-point
        :n "a"    #'outline-show-all
        :n "h"    (cmd! (outline-hide-sublevels 3))
        :n [tab]  #'lexic-toggle-entry
        :n "n"    #'lexic-next-entry
        :n "N"    (cmd! (lexic-next-entry t))
        :n "p"    #'lexic-previous-entry
        :n "P"    (cmd! (lexic-previous-entry t))
        :n "b"    #'lexic-search-history-backwards
        :n "f"    #'lexic-search-history-forwards
        :n "/"    (cmd! (call-interactively #'lexic-search))))

(use-package! nov
  :after nov
  :mode ("\\.epub\\'" . nov-mode)
  :init
  (setq nov-save-place-file (concat doom-etc-dir "nov-places")))

(use-package! org-bullets
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list
        '("●" "○" "◇" "◆")))

(custom-set-faces!
 '(org-level-1 :extend t :height 1.5)
 '(org-level-2 :extend t :height 1.3)
 '(org-level-3 :extend t :height 1.2)
 '(org-level-4 :extend t :height 1.1)
 '(org-level-5 :extend t :height 1.07)
 '(org-level-6 :extend t :height 1.03)
 '(org-level-7 :extend t)
 '(org-level-8 :extend t)
 '(helpful-heading :extend t))

(custom-set-faces!
  '(hl-line :extend t))
