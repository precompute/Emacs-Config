;;; .doom.d/config.el -*- lexical-binding: t; -*-
;;;; measure time! see end of file for explanation
(setq t0 (current-time))

;;;; fonts
;;;;; doom-font
(setq doom-font (font-spec :family "Liga Inconsolata LGC" :size 14)
;;;;; doom-variable-pitch-font
      doom-variable-pitch-font (font-spec :family "Sabon LT Std" :weight 'normal :size 17)
      doom-unicode-font (font-spec :family "Sabon LT Pro" :weight 'normal :size 17)
      doom-serif-font (font-spec :family "Sabon LT Pro" :weight 'normal :size 17))

;;;; keybinds
;;;;; C-s
(map! "C-s"     nil
      "C-s s"   'swiper
      "C-s C-s" 'swiper-isearch
      "M-x"     'counsel-M-x)

;;;;; fn
(map! [f5]    'delete-window
      [s-f5]  'delete-other-windows
      [f7]    'evil-window-split-Cxb
      [f8]    'evil-window-vsplit-Cxb
      [f9]    'save-buffer
      [f12]   'kill-buffer
      [f6]    'timestamp
      [s-f6]  'timestamp-no-time
      [s-f7]  'evil-window-split-ff
      [s-f8]  'evil-window-vsplit-ff
      [s-f10] 'evil-window-split-fr
      [s-f9]  'evil-window-vsplit-fr)

;;;;; mouse
(map! [right-margin mouse-4] 'next-buffer
      [right-margin mouse-5] 'previous-buffer
      [left-margin mouse-4]  '(evil-scroll-up 10)
      [left-margin mouse-5]  '(evil-scroll-down 10)
      [left-fringe mouse-4]  'git-gutter:previous-hunk
      [left-fringe mouse-5]  'git-gutter:next-hunk
      [right-fringe mouse-4] 'next-error
      [right-fringe mouse-5] 'previous-error)

(map! :n [mouse-8] 'evil-jump-backward
      :n [mouse-9] 'evil-jump-forward
      :n "\\"      'repeat)

(map! "C-x T" 'timestamp-no-time)

;;;;; s-evil
(map! "s-h"     'evil-backward-char
      "s-l"     'evil-forward-char
      "s-j"     'next-line
      "s-k"     'previous-line
      "s-v"     'evil-visual-char
      "s-V"     'evil-visual-line
      "s-d"     'evil-delete
      "s-u"     'undo-tree-undo
      "s-U"     'undo-tree-redo
      "s-r"     'evil-replace
      "s-R"     'evil-replace-state
      "s-o"     'evil-open-below
      "s-O"     'evil-open-above
      "s-p"     'evil-paste-after
      "s-P"     'evil-paste-before
      "s-x"     'evil-delete-char
      "s-X"     'evil-delete-backward-char
      "s-y"     'evil-yank
      "s-W"     'evil-forward-WORD-begin
      "s-w"     'evil-forward-word-begin
      "s-e"     'evil-forward-word-end
      "s-E"     'evil-forward-WORD-end
      "s-b"     'evil-backward-word-begin
      "s-B"     'evil-backward-WORD-begin
      "s-/"     'evil-ex-search-forward
      "s-?"     'evil-ex-search-backward
      "s-n"     'evil-ex-search-next
      "s-N"     'evil-ex-search-previous
      "s-a"     'evil-append
      "s-A"     'evil-append-line
      "s-i"     'evil-insert
      "s-I"     'evil-insert-line
      "s-$"     'evil-end-of-visual-line
      "s-%"     'evil-jump-item
      "s-^"     'evil-first-non-blank
      "s--"     'evil-previous-line-first-non-blank
      "s-."     'evil-repeat
      "s-c"     'evil-change
      "s-z s-a" 'evil-toggle-fold
      "s-z s-r" 'evil-open-folds
      "s-z s-m" 'evil-close-folds
      "s-g s-c" 'evil-commentary
      "s-g s-p" '+evil/reselect-paste
      "s-g s-v" 'evil-visual-restore
      "s-*"     'evil-ex-search-word-forward
      "s-#"     'evil-ex-search-word-backward
      "s-g s-d" '+lookup/definition
      "s-z s-s" 'save-buffer
      "s-z s-x" 'kill-current-buffer
      "s-("     'evil-backward-sentence-begin
      "s-)"     'evil-forward-sentence-begin
      "s-="     'evil-indent
      :n evil-normal-state-map "go" 'dumb-jump-go
      :n evil-normal-state-map "gO" 'dumb-jump-back
      :n evil-normal-state-map "g=" 'dumb-jump-go-prompt
      "s-f"     'evil-snipe-f
      "s-s"     'evil-snipe-s
      "s-t"     'evil-snipe-t
      "s-F"     'evil-snipe-F
      "s-S"     'evil-snipe-S
      "s-T"     'evil-snipe-T
      "s-\\"    'repeat
      "s-`"     'evil-e-prompt-c
      "M-s-p"   'evil-paste-pop
      "M-s-n"   'evil-paste-pop-next
      "C-s c" 'complete-symbol
      :map override "s-SPC" #'doom/leader
      :n "U" #'undo-tree-redo)
(windmove-default-keybindings)

;;;;; prefix-leader maps
;;;;;; project
(map! :leader
      (:prefix "p"
        :desc "Find header"    "O"  #'ff-find-other-file))

;;;;;; exclaim
(map! :leader
      (:prefix ("!" . "exclaim")
        :desc "Olivetti Mode"                "o" #'olivetti-mode
        (:prefix ("O" . "search")
          :desc "find file in 46/org" "O"        #'find-file-in-46/org
          :desc "find text in 46/org" "o"        #'find-text-in-46/org
          :desc "Run deft in project root" "d"   #'deft-current-root-c)
        (:prefix ("d" . "diff")
         :desc "Evil Quick Diff Start"        "q" #'evil-quick-diff
         :desc "Evil Quick Diff End"          "Q" #'evil-quick-diff-cancel
         :desc "Magit Diff"                   "g" #'magit-diff
         (:prefix ("v" . "vdiff")
          (:prefix ("f" . "files")
           :desc "Vim Diff 2 Files"             "f" #'vdiff-files
           :desc "Vim Diff 3 Files"             "g" #'vdiff-files3)
          (:prefix ("b" . "buffers")
           :desc "Vim Diff 2 Buffers"           "f" #'vdiff-buffers
           :desc "Vim Diff 3 Buffers"           "g" #'vdiff-buffers3)))
        :desc "Toggle Truncate Window"       "w" #'toggle-truncate-lines
        (:prefix ("W" . "Writing Mode")
         :desc "Enable Writing Mode (c)"      "W" #'enable-writing-mode-c
         :desc "Enable Writing Mode with focus(c)" "w" #'enable-writing-mode-with-focus-c)
        :desc "Switch modus themes"                "t" #'modus-theme-switch-c
        (:prefix ("s" . "shell (vterm)")
         :desc "Open shell in vsplit window"  "s" #'open-shell-vsplit-c
         :desc "Open shell in split window"   "S" #'open-shell-split-c)
        :desc "screenshot (temp)"            "S" #'screenshot-png-c
        :desc "Flip frame"                   "_" #'flip-frame
        :desc "Flop frame"                   "|" #'flop-frame
        :desc "Transpose frame"              "?" #'transpose-frame
        :desc "Rotate frame clockwise"       ">" #'rotate-frame-clockwise
        :desc "Rotate frame anticlockwise"   "<" #'rotate-frame-anticlockwise
        :desc "Hide/Show comments toggle (c)" ";" #'hide/show-comments-toggle-c
        :desc "Follow mode (buffer sync)"    "f" #'follow-mode
        :desc "Git gutter hash"              "g" #'git-gutter:set-start-revision
        :desc "Refile by date (c)"           "-" #'org-timelogrefile-c
        :desc "Scratch-pop"                  "c" #'scratch-pop
        (:prefix ("r" . "Tiny")
         :desc "Tiny Generate (interactive)"  "r" #'tiny-helper
         :desc "Tiny Generate"                "R" #'tiny-expand)
        :desc "Toggle transparency"           "\\" #'toggle-transparency-c))

;;;;;; transient
(map! :leader
      (:prefix ("@" . "transient")
       :desc "org transient"  "o" #'org-transient))

;;;;;; "f"
(map! :leader
      (:prefix "f"
        :desc "fzf dir (counsel)" "g" #'counsel-fzf
        :desc "fzf other dir (counsel)" "G" #'counsel-fzf-other-dir-c))

;;;;;; "o"
(map! :leader
      (:prefix "o"
        :desc "Toggle dired sidebar"                           "p" #'dired-sidebar-toggle-sidebar
        :desc "Toggle dired sidebar for current directory"     "P" #'dired-sidebar-toggle-with-current-directory
        :desc "Toggle imenu-list"                              "i" #'imenu-list-smart-toggle))

;;;;;; "s"
(map! :leader
      (:prefix "s"
        :desc "Dictionary (sdcv)"                           "g" #'sdcv-search-pointer))

(map!
 (:leader
  :desc "M-x" ";" #'execute-extended-command))

;;;;;; text-manage
(map! :leader
      (:prefix ("&" . "text-manage")
       :desc "refile headline to folder under project" "d" #'org-yank-headline-to-dir-c
       :desc "copy link to current heading to directory" "l" #'org-yank-link-to-dir-c
       :desc "copy link and context to current heading to directory" "L" #'org-yank-link-context-to-dir-c
       :desc "empty list of files modified by customrefile" "k" #'customrefile-clean-modified-list
       :desc "print plain modified list" "P" #'customrefile-print-modified-list
       :desc "print checkboxed modified list" "p" #'customrefile-print-checkboxes-modified-list
       ))

(map!
 (:after pdf-view
  (:map pdf-view-mode-map
   "q" nil
   "Q" nil)))

;;;;; C-* / M-* maps
;;;;;; C-*
(map! "C-x C-d" 'ido-dired
      "C-s d"   'org-id-create-copy
      "C-s C-d" 'org-id-paste
      "C-s e"   'org-id-copy
      "C-S-o"   'evil-jump-forward
      "C-s f"   'org-insert-quote-c
      "C-s h"   'org-insert-use-history-c
      "C-s r"   'org-insert-source-c
      "C-s v v" 'org-insert-source-interactive-c
      "C-s v m" 'org-insert-markdown-source-c
      "C-s v s" 'org-insert-shell-source-c
      "C-s C-x" 'throwtext-c
      "C-s x"   'throwtext-save-c
      "C-s C-y" 'placetext-c
      "C-s y"   'placetext-save-c
      "C-s i"   '+lookup/dictionary-definition-lexic
      "C-D" 'scroll-down-c
      "C-U" 'scroll-up-c)

;;;;;; s-*
(map! "s-["     'outline-previous-heading
      "s-]"     'outline-next-heading)

;;;;;; M-s-*
(map! "M-s-j" 'org-merge-next-heading-c
      "M-s-k" 'org-merge-previous-heading-c
      "M-s-e" 'org-headings-equalize
      "M-s-]" 'org-down-element
      "M-s-[" 'org-up-element)

;;;;;; C-H-M-*
(map! "C-H-M-h" 'evil-window-decrease-width
      "C-H-M-j" 'evil-window-decrease-height
      "C-H-M-k" 'evil-window-increase-height
      "C-H-M-l" 'evil-window-increase-width)

;;;;;; C-M-s-*
(map! "C-M-s-h" 'evil-window-left
      "C-M-s-j" 'evil-window-down
      "C-M-s-k" 'evil-window-up
      "C-M-s-l" 'evil-window-right
      "C-M-s-." 'evil-window-bottom-right
      "C-M-s-n" 'evil-window-bottom-left
      "C-M-s-y" 'evil-window-top-left
      "C-M-s-o" 'evil-window-top-right
      "C-M-s-u" 'evil-window-rotate-upwards
      "C-M-s-m" 'evil-window-rotate-downwards
      "C-M-s-g" 'evil-window-far-left
      "C-M-s-;" 'evil-window-far-right
      "C-M-s-i" 'evil-window-very-top
      "C-M-s-," 'evil-window-very-bottom
      :n "zs"   'save-buffer
      :n "zp"   'delete-window
      :n "zo"   'delete-other-windows)

;;;;;; C-M-*
(map! "C-M-g"  'treefactor-throw
      "C-M-y"  'treefactor-org-refactor-heading
      "C-M-_"  'darkroom-decrease-margins
      "C-M-f"  'sp-forward-sexp
      "C-M-b"  'sp-backward-sexp
      "C-M-\\" 'syntactic-close)

;;;;; key chords
(key-chord-mode 1) ;;WOW.
(setq key-chord-two-keys-delay 0.004
      key-chord-in-macros nil)
(key-chord-define-global "zx"     'kill-current-buffer)
(key-chord-define-global "zs"     'save-buffer)
(key-chord-define-global "zp"     'delete-window)
(key-chord-define-global "zo"     'delete-other-windows)
(key-chord-define-global "wh"     'evil-window-left)
(key-chord-define-global "wj"     'evil-window-down)
(key-chord-define-global "wk"     'evil-window-up)
(key-chord-define-global "wl"     'evil-window-right)
(key-chord-define-global "jk"     'evil-escape) ;;whoa
(key-chord-define-global "w("     'evil-window-vsplit-left-c)
(key-chord-define-global "w-"     'evil-window-split-below-c)
(key-chord-define-global "w="     'evil-window-split-above-c)
(key-chord-define-global "w)"     'evil-window-vsplit-right-c)
(key-chord-define-global "ti"     'timestamp)
(key-chord-define-global "do"     'dired-jump)
(key-chord-define-global "dw"     (kbd "s-d w"))
(key-chord-define-global "db"     (kbd "s-d b"))
(key-chord-define-global "vh"     (kbd "s-v h"))
(key-chord-define-global "vj"     (kbd "s-v j"))
(key-chord-define-global "vk"     (kbd "s-v k"))
(key-chord-define-global "vl"     (kbd "s-v l"))
(key-chord-define-global "vi"     (kbd "s-V"))
(key-chord-define-global "sj"     'evil-scroll-down)
(key-chord-define-global "sk"     'evil-scroll-up)
(key-chord-define-global "(o"     'evil-jump-backward)
(key-chord-define-global "o)"     'evil-jump-forward)
(key-chord-define-global "ej"     (kbd "s-p"))
(key-chord-define-global "ek"     (kbd "s-P"))
(key-chord-define-global "fh"     (kbd "s-b"))
(key-chord-define-global "fj"     (kbd "s-)"))
(key-chord-define-global "fk"     (kbd "s-("))
(key-chord-define-global "fl"     (kbd "s-w"))
(key-chord-define-global "gh"     (kbd "s-B"))
(key-chord-define-global "gj"     'evil-forward-paragraph)
(key-chord-define-global "gk"     'evil-backward-paragraph)
(key-chord-define-global "gl"     (kbd "s-W"))
(key-chord-define-global "ch"     (kbd "s-c b"))
(key-chord-define-global "cl"     (kbd "s-c w"))
(key-chord-define-global "ef"     'swiper-isearch)
(key-chord-define-global "oj"     '+evil/insert-newline-below)
(key-chord-define-global "ok"     '+evil/insert-newline-above)
(key-chord-define-global "tj"     'undo-tree-undo)
(key-chord-define-global "tk"     'undo-tree-redo)
(key-chord-define-global "nj"     'evil-ex-search-next)
(key-chord-define-global "nk"     'evil-ex-search-previous)

;;;;; transient
(after! transient
 (transient-define-prefix org-transient () ;;wow
   :transient-suffix     'transient--do-stay
   :transient-non-suffix 'transient--do-warn
   [("h" "previous level" org-up-element)
    ("j" "next visible heading" outline-next-heading)
    ("k" "previous visible heading" outline-previous-heading)
    ("l" "next level" org-down-element)
    ("o" "cycle local" org-cycle)
    ("O" "cycle global" org-shifttab)
    ("n" "equalize" org-headings-equalize)
    ("-" "timelogrefile" org-timelogrefile-c)]))

;;;; configuration
;;;;; org
(setq org-directory "~/46/org/"
      org-attach-id-dir "~/46/org/.attach/"
      org-startup-with-inline-images t
      org-id-locations-file "/home/sys1/46/.orgids"
      org-superstar-prettify-item-bullets nil)
(after! org
  (remove-hook! 'org-mode-hook '(org-superstar-mode writegood-mode flycheck-mode))
  (custom-set-faces! '(org-quote :slant normal))
  (with-no-warnings
    (custom-declare-face '+org-todo-done '((t (:inherit (bold success org-todo)))) "")
    (custom-declare-face '+org-todo-cancel '((t (:inherit (bold font-lock-builtin-face org-todo)))) ""))
  (setq org-time-stamp-custom-formats '("<%y-%m-%d %H:%M:%S>" . "<%y-%m-%d %H:%M:%S>")
        org-time-stamp-formats '("<%y-%m-%d %H:%M:%S>" . "<%y-%m-%d %a %H:%M>")
        org-superstar-mode nil
        org-tsr-regexp-both "[[<]\\([[:digit:]]\\{2\\}-[[:digit:]]\\{2\\}-[[:digit:]]\\{2\\}\\(?: .*?\\)?\\)[]>]\\(--?-?[[<]\\([[:digit:]]\\{2\\}-[[:digit:]]\\{2\\}-[[:digit:]]\\{2\\}\\(?: .*?\\)?\\)[]>]\\)?"
        org-cycle-separator-lines 0
        org-todo-log-states t
        org-treat-insert-todo-heading-as-state-change t
        org-todo-keywords
        '((sequence "TODO(t)" "CNCL(k)" "INPR(s)" "HOLD(h)" "PROJ(p)" "WAIT(w)"
                    "|" "DONE(d)")
          (sequence "[ ](T)" "[-](S)" "[?](W)"
                    "|" "[X](D)"))
        org-todo-keyword-faces
        '(("[-]"  . +org-todo-active)
          ("DONE" . +org-todo-done)
          ("INPR" . +org-todo-active)
          ("[?]"  . +org-todo-onhold)
          ("WAIT" . +org-todo-onhold)
          ("HOLD" . +org-todo-onhold)
          ("CNCL" . +org-todo-cancel)
          ("PROJ" . +org-todo-project))))

;;;;; load! files
(load! "custom/scrollotherwindow.el")

;;;;; visual-line-mode
(global-visual-line-mode 1)

;;;;; modeline
(setq doom-modeline-height 2
      +modeline-height 27
      +modeline-bar-width nil
      doom-modeline-enable-word-count t
      doom-modeline-icon nil)

;;;;; electric pair
(setq electric-quote-replace-double t)

;;;;; org
(setq org-agenda-files (list "/home/sys1/46/org/list/list.org")
      org-hide-emphasis-markers t
      org-popup-calendar-for-date-prompt nil)

;;;;; time
(setq display-time-interval 20
      display-time-mail-string ""
      display-time-default-load-average nil)

;;;;; magit transient
(setq transient-values-file "/home/sys1/.doom.d/transient")

;;;;; ivy
(after! ivy
  (setq ivy-height 22))
(setq ivy-read-action-function #'ivy-hydra-read-action)

;;;;; rainbow delimiters
(setq rainbow-delimiters-max-face-count 6)

;;;;; misc
(auto-image-file-mode)
(setq frame-title-format '("Emacs – %f")
      icon-title-format frame-title-format)

;;;;; dired
(after! dired
  (setq dired-listing-switches "-AGFhlv --group-directories-first --time-style=long-iso"
        wdired-allow-to-change-permissions t)
  (dired-async-mode)
  (dired-async--modeline-mode))
(after! dired-aux
  (setq dired-create-destination-dirs 'ask
        dired-vc-rename-file t))

;;;;; dired-du
(after! dired-du
  (setq dired-du-bind-count-sizes nil
        dired-du-bind-human-toggle nil
        dired-du-bind-mode nil
        dired-du-used-space-program '("du" "-sh")))
(map! :map dired-mode-map
      :ni "gs" #'dired-du-mode)

;;;;; dired-sidebar
(after! dired-sidebar
  (setq dired-sidebar-display-alist '((side . left) (slot . 0))))

;;;;; dired-narrow
(map! :map dired-mode-map
      :ni "g/" #'dired-narrow)

;;;;; dired-collapse
(map! :map dired-mode-map
      :ni "gc" #'dired-collapse-mode)

;;;;; dired-quick-sort
(map! :map dired-mode-map
      :n "g\\" #'hydra-dired-quick-sort/body)
(add-hook! 'dired-mode-hook 'dired-quick-sort)

;;;;; misc
(setq doom-debug-mode nil)
(setq scroll-margin 5
      window-combination-resize nil
      eldoc-idle-delay 0.2)

;;;;; org-sidebar
(after! org-sidebar
  (map! :map org-sidebar-tree-map
        :n "q"       #'org-sidebar-tree-toggle
        :n [tab]     #'org-sidebar-tree-cycle
        :n [backtab] #'org-sidebar-tree-cycle-global
        :n "RET"     #'org-sidebar-tree-jump
        :n "gr"      #'org-sidebar-refresh)
  (setq org-sidebar-tree-side 'left))

;;;;; avy
(after! avy
  (setq avy-all-windows t
        avy-single-candidate-jump t))

;;;;; mini-frame mode
(after! mini-frame
  (setq! mini-frame-show-parameters
         '((left . 0.5)
           (top . 0.4)
           (width . 0.75)
           (height . 1))
         mini-frame-completions-frame t
         mini-frame-color-shift-step 0))

;;;;; ivy-posframe
(after! ivy-posframe
  (setq ivy-posframe-border-width 2
        ivy-posframe-display-functions-alist nil)
  (setf (alist-get t ivy-posframe-display-functions-alist)
        #'+ivy-display-at-custom-pos))

;;;;; company + spellcheck
(set-company-backend! '(text-mode
                        markdown-mode)
  '(:separate company-ispell
    company-files
    company-yasnippet))

;;;;; scratch-pop & unkillable-scratch
(after! scratch-pop
  (unkillable-scratch)
  (setq unkillable-scratch-behavior 'do-nothing))
(setq scratch-pop-backup-directory (concat doom-cache-dir "scratch-pop"))

;;;;; magit
(advice-add #'magit-version :override #'ignore)
(setq +magit--ignore-version-a nil)
(setq auth-sources '("~/.doom.d/magitauthinfo"))

;;;;; calibredb
(setq calibredb-root-dir "~/temp/del/calibreback/99"
      calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir)
      calibredb-program "/opt/calibre/calibredb"
      sql-sqlite-program "/usr/bin/sqlite3"
      calibredb-library-alist '(("~/temp/del/calibreback/99")
                                ("~/99")))

;;;;; ispell
(setq ispell-dictionary "en_custom"
      ispell-program-name "hunspell"
      ispell-personal-dictionary (expand-file-name ".ispell_personal" doom-private-dir))

;;;;; ccm (centered cursor mode)
(setq ccm-animation-delay 0
      ccm-step-delay 0
      ccm-step-size 0
      ccm-recenter-at-end-of-file t)

;;;;; fringe, git-gutter-fringe
(setq fringe-mode '4)
(after! git-gutter-fringe
  (when +vc-gutter-default-style
    (if (fboundp 'fringe-mode) (fringe-mode '4))
    (define-fringe-bitmap 'git-gutter-fr:added [0]
      nil nil '(center repeated))
    (define-fringe-bitmap 'git-gutter-fr:modified [0]
      nil nil '(center repeated))))

;;;;; misc
(setq x-stretch-cursor t)
(setq +workspaces-on-switch-project-behavior nil)
(setq uniquify-buffer-name-style 'forward)
(setq which-key-idle-delay 0.5
(setq nav-flash-delay 0.3)
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(setq fancy-splash-image "~/.doom.d/splash.jpg")
(setq display-line-numbers-type nil
      display-line-numbers-width 5)
(add-to-list 'auto-mode-alist '("\\.rkt$" . racket-mode))

;;;;; pdf-view
(after! pdf-view
  (setq pdf-view-midnight-colors '("#ffffff" . "#000000")))

;;;;; deft
(after! deft
  (setq deft-directory "~/46/org"
        deft-recursive t
        deft-current-sort-method 'mtime
        deft-use-filename-as-title t
        deft-separator "->"))

;;;;; recentf
(after! recentf (setq-default recentf-max-saved-items 999999))

;;;;; counsel-rg
(setq counsel-rg-base-command
      `("rg"
        "--with-filename"
        "--no-heading"
        "--line-number"
        "--color" "never"
        "-uu"
        "--no-ignore"
        "--smart-case"
        "--threads" "4"
        "%s"))

;;;;; evil
(setq evil-goggles-duration 0.5
(setq evil-move-cursor-back nil)
(remove-hook 'evil-insert-state-entry-hook #'delete-selection-mode)

;;;;; markdown
(setq markdown-header-scaling t
      markdown-hide-markup t)
(map!
 (:after markdown-mode
  (:map markdown-mode-map
   :nv "j" #'evil-next-visual-line
   :nv "k" #'evil-previous-visual-line
   :desc "pandoc hydra" "C-c /" #'pandoc-mode-hydra)))

;;;;; company
(setq company-idle-delay nil)
(setq company-box-doc-delay nil)
(setq tooltip-idle-delay 0)

;;;;; swiper
(setq swiper-use-visual-line nil)
(setq swiper-use-visual-line-p (lambda (a) nil))

;;;;; paren
(setq show-paren-style 'expression
      show-paren-delay 0)

;;;;; misc
(setq indicate-buffer-boundaries t
      indicate-empty-lines t)

;;;;; prescient
(after! prescient
  (setq prescient-filter-method
        '(regexp
          fuzzy))
  (setq prescient-frequency-threshold 0.5
        prescient-frequency-decay 0.5))

;;;;; neotree
(after! neotree
  (setq neo-theme 'icons)
  (setq neo-smart-open t))

;;;;; imenu
(after! imenu
  (setq imenu-auto-rescan t
        imenu-max-item-length 120
        imenu-space-replacement " ")
  (flimenu-mode))

;;;;; imenu-list
(after! imenu-list
  (setq imenu-list-position 'right
        imenu-list-size 40
        imenu-list-focus-after-activation t)
  (set-popup-rule! "^\\*Ilist\\*$"
    :actions '(+popup-display-buffer-stacked-side-window-fn)
    :side 'right
    :width 50
    :modeline nil
    :select t
    :quit t))

;;;;; flimenu

;;;;; keycast
(after! keycast
  (setq keycast-insert-after '+modeline-format-left
        keycast-separator-width 1
        keycast-remove-tail-elements nil
        mode-line-keycast-format "%s%k%c%r"))

;;;;; outline-minor-mode & bicycle-cycle
(after! outline
  (add-hook 'outline-minor-mode-hook 'outline-minor-faces-add-font-lock-keywords)
  (map! :map outline-minor-mode-map
        :ni [tab] #'bicycle-cycle
        :ni [backtab] #'bicycle-cycle-global))

;;;;;; backline
(after! outline
  (advice-add 'outline-flag-region :after 'backline-update))

;;;;; misc
(advice-add #'ffap-guesser :override #'ignore)
(add-hook 'hoon-mode #'lsp)

;;;;; olivetti
(setq olivetti-body-width 135)
(setq olivetti-enable-visual-line-mode nil)
(setq olivetti-recall-visual-line-mode-entry-state t)
(add-hook! '(prog-mode-hook text-mode-hook dired-mode-hook conf-mode-hook)
           #'olivetti-mode)

;;;;; lexic
(after! lexic
  (set-popup-rule! "^\\*lexic\\*$"
    :actions '(+popup-display-buffer-stacked-side-window-fn)
    :side 'left :width 50 :slot -1 :modeline nil :select t :quit t))

;;;;; misc hooks
(add-hook! 'lexic-mode-hook #'mixed-pitch-mode)
(remove-hook! 'dired-mode-hook #'dired-omit-mode)
(use-package mixed-pitch :hook (org-mode . mixed-pitch-mode))
(solaire-global-mode -1)

;;;;; unicode fonts

;;;;; hl-line
(remove-hook! '(prog-mode-hook
                text-mode-hook
                conf-mode-hook
                special-mode-hook) #'hl-line-mode)
(add-hook! '(dired-mode-hook) #'hl-line-mode)

;;;; visual customizations
;;;;; outline-*
(custom-set-faces!
  '(outline-1 :height 1.5)
  '(outline-2 :height 1.3)
  '(outline-3 :height 1.2)
  '(outline-4 :height 1.1)
  '(outline-5 :height 1.07)
  '(outline-6 :height 1.03))

(custom-set-faces! '(org-quote :slant normal))

;;;;; org-level-*
(custom-set-faces!
  '(org-level-1 :height 1.5)
  '(org-level-2 :height 1.3)
  '(org-level-3 :height 1.2)
  '(org-level-4 :height 1.1)
  '(org-level-5 :height 1.07)
  '(org-level-6 :height 1.03))
(setq so-long-threshold 220)

;;;;; markdown-header-face-*
(custom-set-faces!
  '(markdown-header-face-1 :height 1.5)
  '(markdown-header-face-2 :height 1.3)
  '(markdown-header-face-3 :height 1.2)
  '(markdown-header-face-4 :height 1.1)
  '(markdown-header-face-5 :height 1.07)
  '(markdown-header-face-6 :height 1.03))

;;;;; rst-level-*
(custom-set-faces!
  '(rst-level-1 :height 1.5)
  '(rst-level-2 :height 1.3)
  '(rst-level-3 :height 1.2)
  '(rst-level-4 :height 1.1)
  '(rst-level-5 :height 1.07)
  '(rst-level-6 :height 1.03))

;;;;; transparency
(set-frame-parameter (selected-frame) 'alpha '(97 . 97))
(add-to-list 'default-frame-alist '(alpha . (97 . 97)))

;;;; other
;;;;; misc
(setq annotate-file "~/.doom.d/other/annotations")
(setq evil-escape-key-sequence "kj"
      evil-vsplit-window-right t
      evil-split-window-below t
      evil-escape-delay 0.2)
(setq undo-limit 80000000)
(setq +ivy-buffer-preview t)
(setq org-use-property-inheritance t
      org-log-done 'time
      org-list-allow-alphabetical t
      org-export-in-background t
      org-catch-invisible-edits 'error)

;;;;; spell
(remove-hook! '(org-mode-hook TeX-mode-hook
               rst-mode-hook mu4e-compose-mode-hook
               message-mode-hook git-commit-mode-hook
               prog-mode-hook text-mode-hook
               dired-mode-hook conf-mode-hook)
             #'flyspell-mode)
(add-hook! 'markdown-mode-hook #'flyspell-mode)
(map! :map flyspell-mode-map
      :n "zq" 'add-word-to-pdic-c)

;;;; themes
;;;;; subatomic
(setq subatomic-high-contrast t)
(setq subatomic-more-visible-comment-delimiters t)

;;;;; henna
(setq doom-henna-brighter-modeline t
      doom-henna-brighter-comments t
      doom-henna-comment-bg t)

;;;;; acario
(setq doom-acario-light-brighter-modeline t
      doom-acario-light-padded-modeline t)

;;;;; outrun-electric
(setq doom-outrun-electric-comment-bg t)

;;;;; one
(setq doom-one-comment-bg t)
(setq doom-one-light-brighter-modeline t
      doom-one-light-comment-bg t)

;;;;; nord
(setq doom-nord-light-brighter-comments t
      doom-nord-light-comment-bg t)

(setq doom-nord-brighter-comments t
      doom-nord-comment-bg t)

;;;;; gruvbox
(setq doom-gruvbox-light-brighter-modeline t
      doom-gruvbox-dark-variant "hard")

;;;;; peacock
(setq doom-peacock-brighter-modeline t
      doom-peacock-brighter-comments t
      doom-peacock-comment-bg t)

;;;;; oceanic-next
(setq doom-oceanic-next-brighter-modeline t
      doom-oceanic-next-comment-bg t)

;;;;; modus-operandi
(setq modus-operandi-theme-slanted-constructs t
      modus-operandi-theme-bold-constructs t
      modus-operandi-theme-org-blocks 'greyscale
      modus-operandi-theme-prompts 'intense
      modus-operandi-theme-completions 'opinionated
      modus-operandi-theme-intense-paren-match t
      modus-operandi-theme-fringes nil
      modus-operandi-theme-intense-hl-line nil
      modus-operandi-theme-headings '((t . rainbow-line-no-bold))
      modus-operandi-theme-mode-line '3d
      modus-operandi-theme-scale-headings t
      modus-operandi-theme-diffs 'desaturated
      modus-operandi-theme-scale-5 1.9
      modus-operandi-theme-scale-4 1.6
      modus-operandi-theme-scale-3 1.3
      modus-operandi-theme-scale-2 1.1
      modus-operandi-theme-scale-1 1.0
      modus-operandi-theme-override-colors-alist '(("cyan-nuanced-bg" . "#fff3da") ("cyan-nuanced" . "#5d3026")))

;;;;; modus-vivendi
(setq modus-vivendi-theme-slanted-constructs t
      modus-vivendi-theme-bold-constructs t
      modus-vivendi-theme-org-blocks 'greyscale
      modus-vivendi-theme-prompts 'intense
      modus-vivendi-theme-completions 'opinionated
      modus-vivendi-theme-intense-paren-match t
      modus-vivendi-theme-fringes nil
      modus-vivendi-theme-intense-hl-line nil
      modus-vivendi-theme-headings '((t . rainbow-line-no-bold))
      modus-vivendi-theme-mode-line '3d
      modus-vivendi-theme-scale-headings t
      modus-vivendi-theme-diffs 'desaturated
      modus-vivendi-theme-scale-5 1.9
      modus-vivendi-theme-scale-4 1.6
      modus-vivendi-theme-scale-3 1.3
      modus-vivendi-theme-scale-2 1.1
      modus-vivendi-theme-scale-1 1.0
      modus-vivendi-theme-override-colors-alist '(("cyan-nuanced-bg" . "#18140a") ("cyan-nuanced" . "#f8dec0")))

;;;;; tao
(setq tao-theme-use-sepia t
      tao-theme-sepia-depth 4
      tao-theme-sepia-saturation 0.4
      tao-theme-use-boxes t
      tao-theme-use-height nil)

;;;;; setq doom-theme
(setq doom-theme 'modus-vivendi)

;;;; file loads
(load! "+functions.el")
(load! "+config.functions.el")
(load! "+custom.el")

;;;; profiling
(let ((elapsed (float-time (time-subtract (current-time) t0))))
  (makunbound 't0)
  (message "spent %.3fs in config.el" elapsed))
;;;; end
