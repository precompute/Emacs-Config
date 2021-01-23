;;; .doom.d/config.el -*- lexical-binding: t; -*-
;;;; measure time! see end of file for explanation
(setq t0 (current-time))

;;;; fonts
;;;;; doom-font
(setq doom-font (font-spec :family "Bitstream Vera Sans Mono" :size 16)
;;;;; doom-variable-pitch-font
      ;; doom-variable-pitch-font (font-spec :family "Century Expanded LT Std" :weight 'normal :size 19)
      ;; doom-variable-pitch-font (font-spec :family "Inter" :weight 'semi-bold :size 17)
      ;; doom-variable-pitch-font (font-spec :family "Inter" :size 17)
      doom-variable-pitch-font (font-spec :family "Helvetica LT Com" :weight 'normal :size 18)
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
(global-set-key (kbd "s-h")     'evil-backward-char)
(global-set-key (kbd "s-l")     'evil-forward-char)
(global-set-key (kbd "s-j")     'next-line) ;works!
(global-set-key (kbd "s-k")     'previous-line)
(global-set-key (kbd "s-v")     'evil-visual-char)
(global-set-key (kbd "s-V")     'evil-visual-line)
(global-set-key (kbd "s-d")     'evil-delete) ;dd
(global-set-key (kbd "s-u")     'undo-tree-undo)
(global-set-key (kbd "s-U")     'undo-tree-redo)
(global-set-key (kbd "s-r")     'evil-replace)
(global-set-key (kbd "s-R")     'evil-replace-state)
(global-set-key (kbd "s-o")     'evil-open-below)
(global-set-key (kbd "s-O")     'evil-open-above)
(global-set-key (kbd "s-p")     'evil-paste-after)
(global-set-key (kbd "s-P")     'evil-paste-before)
(global-set-key (kbd "s-x")     'evil-delete-char)
(global-set-key (kbd "s-X")     'evil-delete-backward-char)
(global-set-key (kbd "s-y")     'evil-yank) ;yy
(global-set-key (kbd "s-W")     'evil-forward-WORD-begin)
(global-set-key (kbd "s-w")     'evil-forward-word-begin)
(global-set-key (kbd "s-e")     'evil-forward-word-end)
(global-set-key (kbd "s-E")     'evil-forward-WORD-end)
(global-set-key (kbd "s-b")     'evil-backward-word-begin)
(global-set-key (kbd "s-B")     'evil-backward-WORD-begin)
(global-set-key (kbd "s-/")     'evil-ex-search-forward)
(global-set-key (kbd "s-?")     'evil-ex-search-backward)
(global-set-key (kbd "s-n")     'evil-ex-search-next)
(global-set-key (kbd "s-N")     'evil-ex-search-previous)
(global-set-key (kbd "s-a")     'evil-append)
(global-set-key (kbd "s-A")     'evil-append-line)
(global-set-key (kbd "s-i")     'evil-insert)
(global-set-key (kbd "s-I")     'evil-insert-line)
(global-set-key (kbd "s-G")     'evil-goto-line)
(global-set-key (kbd "s-$")     'evil-end-of-visual-line)
(global-set-key (kbd "s-%")     'evil-jump-item)
(global-set-key (kbd "s-^")     'evil-first-non-blank)
(global-set-key (kbd "s--")     'evil-previous-line-first-non-blank)
(global-set-key (kbd "s-.")     'evil-repeat)
(global-set-key (kbd "s-c")     'evil-change)
(global-set-key (kbd "s-J")     'evil-join)
(global-set-key (kbd "s-z s-a") 'evil-toggle-fold)
(global-set-key (kbd "s-z s-r") 'evil-open-folds)
(global-set-key (kbd "s-z s-m") 'evil-close-folds)
(global-set-key (kbd "s-z s-z") 'evil-scroll-line-to-center)
(global-set-key (kbd "s-g s-c") 'evil-commentary)
(global-set-key (kbd "s-g s-p") '+evil/reselect-paste)
(global-set-key (kbd "s-g s-v") 'evil-visual-restore)
(global-set-key (kbd "s-*")     'evil-ex-search-word-forward)
(global-set-key (kbd "s-#")     'evil-ex-search-word-backward)
(global-set-key (kbd "s-g s-d") '+lookup/definition)
(global-set-key (kbd "s-z s-s") 'save-buffer)
(global-set-key (kbd "s-z s-x") 'kill-current-buffer)
(global-set-key (kbd "s-(")     'evil-backward-sentence-begin)
(global-set-key (kbd "s-)")     'evil-forward-sentence-begin)
(global-set-key (kbd "s-=")     'evil-indent)
(define-key evil-normal-state-map "go" 'dumb-jump-go)
(define-key evil-normal-state-map "gO" 'dumb-jump-back)
(define-key evil-normal-state-map "g=" 'dumb-jump-go-prompt)
(global-set-key (kbd "s-f")     'evil-snipe-f)
(global-set-key (kbd "s-s")     'evil-snipe-s)
(global-set-key (kbd "s-t")     'evil-snipe-t)
(global-set-key (kbd "s-F")     'evil-snipe-F)
(global-set-key (kbd "s-S")     'evil-snipe-S)
(global-set-key (kbd "s-T")     'evil-snipe-T)
(global-set-key (kbd "s-\\")    'repeat)
(global-set-key (kbd "s-`")     'evil-e-prompt-c)
(global-set-key (kbd "M-s-p")   'evil-paste-pop)
(global-set-key (kbd "M-s-n")   'evil-paste-pop-next)

(windmove-default-keybindings)

(global-set-key (kbd "C-s c") 'complete-symbol)

(map! :map override "s-SPC" #'doom/leader)

(map! :n "U" #'undo-tree-redo)

;;;;; prefix-leader maps
;;;;;; project
(map! :leader
      ;; (:prefix-map ("p" . "project") ;;apparently prefix-map shouldn't be used
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
        :desc "Switch modus themes"                "t" #'custom-theme-switch-c
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
        :desc "fzf other dir (counsel)"     "G" #'counsel-fzf-other-dir-c
        :desc "counsel projectile find dir" "a" #'counsel-projectile-find-dir
        ))

;;;;;; "o"
(map! :leader
      (:prefix "o"
        :desc "Toggle dired sidebar"                           "p" #'dired-sidebar-toggle-sidebar
        :desc "Toggle dired sidebar for current directory"     "P" #'dired-sidebar-toggle-with-current-directory
        :desc "Toggle imenu-list"                              "i" #'imenu-list-smart-toggle
        :desc "dired"                                          "o" #'dired-jump))

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
       :desc "" "d" #'refile2-copy-headline
       :desc "" "l" #'refile2-link-headline
       :desc "" "L" #'refile2-link-headline-with-context
       :desc "" "k" #'refile2-clean-modified-list
       :desc "" "P" #'refile2-print-checkboxes-modified-list
       :desc "" "p" #'refile2-print-modified-list))

(map!
 (:after pdf-view
  (:map pdf-view-mode-map
   "q" nil
   "Q" nil)))

;;;;;; rotate
(map! (:when (featurep! :editor rotate-text)
       :n "!"  #'rotate-text ;; e408c045485365d7ff8b34dbc3912557b546d2ae
       :n "]r"  #'nil
       :n "[r"  #'nil))

;;;;; C-* / M-* maps
;;;;;; M-*

;;;;;; C-*
(global-set-key (kbd "C-x C-d") 'ido-dired)
(global-set-key (kbd "C-s d")   'org-id-create-copy)
(global-set-key (kbd "C-s C-d") 'org-id-paste)
(global-set-key (kbd "C-s e")   'org-id-copy)
(global-set-key (kbd "C-S-o")     'evil-jump-forward)
(global-set-key (kbd "C-s f")   'org-insert-quote-c)
(global-set-key (kbd "C-s h")   'org-insert-use-history-c)
(global-set-key (kbd "C-s r")   'org-insert-source-c)
(global-set-key (kbd "C-s v v") 'org-insert-source-interactive-c)
(global-set-key (kbd "C-s v m") 'org-insert-markdown-source-c)
(global-set-key (kbd "C-s v s") 'org-insert-shell-source-c)
(global-set-key (kbd "C-s C-x") 'throwtext-c)
(global-set-key (kbd "C-s x")   'throwtext-save-c)
(global-set-key (kbd "C-s C-y") 'placetext-c)
(global-set-key (kbd "C-s y")   'placetext-save-c)
(global-set-key (kbd "C-s i")   '+lookup/dictionary-definition-lexic)
(global-set-key (kbd "C-s \(")   'custom-surround)
(global-set-key (kbd "C-s \)")   'custom-surround-previous)
(map! "C-D" 'scroll-down-c
      "C-U" 'scroll-up-c)
(global-set-key (kbd "C-s-[")     'org-contract-current-heading-move-backward-c)
(global-set-key (kbd "C-s-]")     'org-contract-current-heading-move-forward-c)

;;;;;; H-*
(map!
 "H-t" #'refile2-copy-headline
 "H-l" #'refile2-link-headline
 "H-L" #'refile2-link-headline-with-context
 "H-r" #'refile2-relative-copy-headline
 "H-k" #'refile2-relative-link-headline
 "H-K" #'refile2-relative-link-headline-with-context
 "H-z" #'refile2-clean-modified-list
 "H-P" #'refile2-print-checkboxes-modified-list
 "H-p" #'refile2-print-modified-list
 "H-c" #'git-auto-time-commit
 "H-C" #'git-prompt-commit
 "H-i" #'org-split-block-c
 "H-j" #'org-headings-equalize)

(map!
 "H--" #'org-hide-block-all
 "H-=" #'org-show-block-all)

;;;;;; s-*
(global-set-key (kbd "s-[")     'outline-previous-heading)
(global-set-key (kbd "s-]")     'outline-next-heading)
(map! "s-z s-x" #'kill-current-buffer)
(map! "s-z s-s" #'save-buffer)
(map! "s-z s-p" #'delete-window)
(map! "s-z s-o" #'delete-other-windows)

;;;;;; M-s-*
(map! "M-s-e" 'org-headings-equalize)
(global-set-key (kbd "M-s-]") 'org-down-element)
(global-set-key (kbd "M-s-[") 'org-up-element)
(map! :n "M-s-h" 'spatial-navigate-backward-horizontal-box
      :n "M-s-j" 'spatial-navigate-forward-vertical-box
      :n "M-s-k" 'spatial-navigate-backward-vertical-box
      :n "M-s-l" 'spatial-navigate-forward-horizontal-box
      :i "M-s-h" 'spatial-navigate-backward-horizontal-bar
      :i "M-s-j" 'spatial-navigate-forward-vertical-bar
      :i "M-s-k" 'spatial-navigate-backward-vertical-bar
      :i "M-s-l" 'spatial-navigate-forward-horizontal-bar)

;;;;;; C-H-M-*
(global-set-key (kbd "C-H-M-h") 'evil-window-decrease-width)
(global-set-key (kbd "C-H-M-j") 'evil-window-decrease-height)
(global-set-key (kbd "C-H-M-k") 'evil-window-increase-height)
(global-set-key (kbd "C-H-M-l") 'evil-window-increase-width)

;;;;;; C-M-s-*
(global-set-key (kbd "C-M-s-h") 'evil-window-left)
(global-set-key (kbd "C-M-s-j") 'evil-window-down)
(global-set-key (kbd "C-M-s-k") 'evil-window-up)
(global-set-key (kbd "C-M-s-l") 'evil-window-right)
(global-set-key (kbd "C-M-s-.") 'evil-window-bottom-right)
(global-set-key (kbd "C-M-s-n") 'evil-window-bottom-left)
(global-set-key (kbd "C-M-s-y") 'evil-window-top-left)
(global-set-key (kbd "C-M-s-o") 'evil-window-top-right)
(global-set-key (kbd "C-M-s-u") 'evil-window-rotate-upwards)
(global-set-key (kbd "C-M-s-m") 'evil-window-rotate-downwards)
(global-set-key (kbd "C-M-s-g") 'evil-window-far-left)
(global-set-key (kbd "C-M-s-;") 'evil-window-far-right)
(global-set-key (kbd "C-M-s-i") 'evil-window-very-top)
(global-set-key (kbd "C-M-s-,") 'evil-window-very-bottom)

(map! :n "zs"     'save-buffer
      :n "zp"     'delete-window
      :n "zo"     'delete-other-windows)

;;;;;; C-M-*
(global-set-key (kbd "C-M-_") 'darkroom-decrease-margins)
(global-set-key (kbd "C-M-f") 'sp-forward-sexp)
(global-set-key (kbd "C-M-b") 'sp-backward-sexp)
(global-set-key (kbd "C-M-\\") 'syntactic-close)

;;;;; key chords
(key-chord-mode 1)
(setq key-chord-two-keys-delay 0.003
      key-chord-in-macros nil)
(key-chord-define-global "zx"     'kill-current-buffer)
(key-chord-define-global "zs"     'save-buffer)
(key-chord-define-global "zp"     'delete-window)
(key-chord-define-global "zo"     'delete-other-windows)
(key-chord-define-global "wh"     'evil-window-left)
(key-chord-define-global "wj"     'evil-window-down)
(key-chord-define-global "wk"     'evil-window-up)
(key-chord-define-global "wl"     'evil-window-right)
(key-chord-define-global "jk"     'evil-escape)
(key-chord-define-global "w("     'evil-window-vsplit-left-c)
(key-chord-define-global "w-"     'evil-window-split-below-c)
(key-chord-define-global "w="     'evil-window-split-above-c)
(key-chord-define-global "w)"     'evil-window-vsplit-right-c)
(key-chord-define-global "ef"     'swiper-isearch)

;;;;; transient
(after! transient
 (transient-define-prefix org-transient ()
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
      org-startup-with-inline-images t)
(setq org-tsr-regexp-both
      "[[<]\\([[:digit:]]\\{2\\}-[[:digit:]]\\{2\\}-[[:digit:]]\\{2\\}\\(?: .*?\\)?\\)[]>]\\(--?-?[[<]\\([[:digit:]]\\{2\\}-[[:digit:]]\\{2\\}-[[:digit:]]\\{2\\}\\(?: .*?\\)?\\)[]>]\\)?")
(setq org-id-locations-file "/home/sys1/46/.orgids")
(setq org-superstar-prettify-item-bullets nil)
(after! org
  (setq org-time-stamp-custom-formats '("<%y-%m-%d %H:%M:%S>" . "<%y-%m-%d %H:%M:%S>"))
  (setq org-time-stamp-formats '("<%y-%m-%d %H:%M:%S>" . "<%y-%m-%d %a %H:%M>"))
  (remove-hook 'org-mode-hook #'org-superstar-mode)
  (remove-hook 'org-mode-hook #'writegood-mode)
  (remove-hook 'org-mode-hook #'flycheck-mode)
  (setq org-superstar-mode nil)
  (setq org-tsr-regexp-both
        "[[<]\\([[:digit:]]\\{2\\}-[[:digit:]]\\{2\\}-[[:digit:]]\\{2\\}\\(?: .*?\\)?\\)[]>]\\(--?-?[[<]\\([[:digit:]]\\{2\\}-[[:digit:]]\\{2\\}-[[:digit:]]\\{2\\}\\(?: .*?\\)?\\)[]>]\\)?")
  (custom-set-faces!
    '(org-quote :slant normal))
  (setq org-cycle-separator-lines 0)
  (setq org-todo-log-states t)
  (setq org-treat-insert-todo-heading-as-state-change t)
  (setq org-fontify-todo-headline t)
  (with-no-warnings
    (custom-declare-face '+org-todo-done '((t (:inherit (bold success org-todo)))) "")
    (custom-declare-face '+org-todo-cancel '((t (:inherit (bold font-lock-builtin-face org-todo)))) ""))
  (setq org-todo-keywords
        '((sequence
           "TODO(t)" 
           "CNCL(k)"
           "INPR(s)"
           "HOLD(h)"
           "PROJ(p)"
           "WAIT(w)"
           "|"
           "DONE(d)"
           )
          (sequence
           "[ ](T)"
           "[-](S)"
           "[?](W)"
           "|"
           "[X](D)"))))

(setq-hook! '(org-mode-hook)
  olivetti-body-width 105)

;;;;; load! files
(load! "custom/scrollotherwindow.el")
(load! "custom/refile2.el")
(load! "custom/kindleclippings.el")

;;;;; visual-line-mode
(global-visual-line-mode 1)

;;;;; modeline
(setq doom-modeline-height 2)
(setq! +modeline-height 27)
(setq +modeline-bar-width nil)
(setq doom-modeline-enable-word-count t)
(setq doom-modeline-icon nil)

;;;;; electric pair
(setq electric-quote-replace-double t)

;;;;; org
(setq org-agenda-files
      (directory-files-recursively "~/46/textmindtest/one" (rx "Agenda.org" eos)))
(setq org-hide-emphasis-markers t)
(setq org-popup-calendar-for-date-prompt nil)

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
(setq frame-title-format (concat "Emacs – %f")
      icon-title-format frame-title-format)

;;;;; dired
(after! dired
  (setq dired-listing-switches "-AGFhlv --group-directories-first --time-style=long-iso"
        wdired-allow-to-change-permissions t)
  (dired-async-mode)
  (dired-async--modeline-mode)
  (map! :map dired-mode-map
        :ni "K" #'dired-kill-line))
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

(setq-hook! '(dired-sidebar-mode-hook)
  truncate-lines t)

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

;;;;; dired-posframe
(map! :map dired-mode-map
      :n "gp" #'dired-posframe-mode)
(after! dired-posframe
  (setq dired-posframe-height 30
        dired-posframe-width 100))

;;;;; misc
(setq doom-debug-mode nil)

(setq scroll-margin 10
      window-combination-resize nil
      eldoc-idle-delay 0.2
      )

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
(setq calibredb-root-dir "~/99"
      calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir)
      calibredb-program "/opt/calibre/calibredb"
      sql-sqlite-program "/usr/bin/sqlite3"
      calibredb-comment-width -1
      calibredb-title-width -1
      calibredb-library-alist '(("~/99")))

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
(setq which-key-idle-delay 1.5)
(setq nav-flash-delay 0.3)
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(setq fancy-splash-image "~/.doom.d/splash.jpg")
(setq display-line-numbers-type nil)
(setq display-line-numbers-width 5)
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
(after! recentf
  (setq-default recentf-max-saved-items 999999))

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
(setq evil-goggles-duration 0.5)
(setq evil-move-cursor-back nil)
(remove-hook 'evil-insert-state-entry-hook #'delete-selection-mode)
(setq evil-auto-balance-windows nil)

;;;;; ligatures
(setq +ligatures-extra-symbols nil)

;;;;; markdown
(setq markdown-header-scaling t
      markdown-hide-markup-in-view-modes nil
      markdown-hide-markup nil)
(map!
 (:after markdown-mode
  (:map markdown-mode-map
   :nv "j" #'evil-next-visual-line
   :nv "k" #'evil-previous-visual-line
   :desc "pandoc hydra" "C-c /" #'pandoc-mode-hydra)))

;;;;; company
(setq company-idle-delay nil)
(setq company-box-doc-delay nil)
(setq tooltip-idle-delay 0
      company-tooltip-limit 6)

;;;;; swiper
(setq swiper-use-visual-line nil)
(setq swiper-use-visual-line-p (lambda (a) nil))

;;;;; paren
(setq show-paren-style 'parenthesis
      show-paren-delay 0)

;;;;; misc
(setq indicate-buffer-boundaries '((top . left) (t . right))
      indicate-empty-lines t)
(setq auto-save-default nil
      auto-save-include-big-deletions nil)
(setq doom-big-font-increment 2)

;;;;; prescient
(after! prescient
  (setq prescient-filter-method
        '(initialism
          literal
          regexp
          prefix
          anchored
          literal-prefix))
  (setq prescient-frequency-threshold 0.5
        prescient-frequency-decay 0.5
        history-length 999999
        prescient-history-length 999999))

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
    :side 'left
    :width 40
    :modeline nil
    :select t
    :quit t)
  (setq-hook! '(imenu-list-major-mode-hook
                imenu-list-minor-mode-hook)
    truncate-lines t))

;;;;; flimenu
(flimenu-global-mode)

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
        :n [tab] #'bicycle-cycle
        :n [backtab] #'bicycle-cycle-global))

;;;;;; backline
(after! outline
  (advice-add 'outline-flag-region :after 'backline-update))

;;;;; misc
(advice-add #'ffap-guesser :override #'ignore)
(add-hook 'hoon-mode #'lsp)
(map! :map prog-mode-map
      :i [tab] #'escape-sexp
      :i [backtab] #'escape-sexp-backwards)

;;;;; olivetti
(setq olivetti-body-width 135)
(setq olivetti-enable-visual-line-mode nil)
(setq olivetti-recall-visual-line-mode-entry-state t)
(add-hook! '(prog-mode-hook
             text-mode-hook
             dired-mode-hook
             conf-mode-hook)
           #'olivetti-mode)

;;;;; lexic
(after! lexic
  (set-popup-rule! "^\\*lexic\\*$"
    :actions '(+popup-display-buffer-stacked-side-window-fn)
    :side 'left
    :width 50
    :slot -1
    :modeline nil
    :select t
    :quit t))

;;;;; misc hooks
(add-hook! 'lexic-mode-hook #'mixed-pitch-mode)
(add-hook! 'markdown-mode-hook #'mixed-pitch-mode)
(remove-hook! 'dired-mode-hook #'dired-omit-mode)
(use-package mixed-pitch
  :hook (org-mode . mixed-pitch-mode))
(setq mixed-pitch-set-height t)
(solaire-global-mode -1)
(remove-hook! '(org-mode-hook)
  #'yas-minor-mode-on)
(setq-hook! '(elfeed-search-update-hook)
  truncate-lines t
  display-line-numbers t)

;;;;; hl-line
(setq global-hl-line-modes '(dired-mode))

;;;; visual customizations
;;;;; outline-*
(custom-set-faces!
  '(outline-1 :height 1.5)
  '(outline-2 :height 1.3)
  '(outline-3 :height 1.2)
  '(outline-4 :height 1.1)
  '(outline-5 :height 1.07)
  '(outline-6 :height 1.03)
  )

(custom-set-faces!
  '(org-quote :slant normal))

;;;;; org-level-*
(setq so-long-threshold 220)

;;;;; markdown-header-face-*
(custom-set-faces!
  '(markdown-header-face-1 :height 1.5)
  '(markdown-header-face-2 :height 1.3)
  '(markdown-header-face-3 :height 1.2)
  '(markdown-header-face-4 :height 1.1)
  '(markdown-header-face-5 :height 1.07)
  '(markdown-header-face-6 :height 1.03)
  )

;;;;; rst-level-*
(custom-set-faces!
  '(rst-level-1 :height 1.5)
  '(rst-level-2 :height 1.3)
  '(rst-level-3 :height 1.2)
  '(rst-level-4 :height 1.1)
  '(rst-level-5 :height 1.07)
  '(rst-level-6 :height 1.03)
  )

;;;;; transparency
(set-frame-parameter (selected-frame) 'alpha '(97 . 97))
(add-to-list 'default-frame-alist '(alpha . (97 . 97)))

;;;; other
;;;;; misc
(setq annotate-file "~/.doom.d/other/annotations")

(setq evil-escape-key-sequence "kj"
      evil-escape-delay 0.2)

(setq undo-limit 80000000)
(setq evil-vsplit-window-right t)
(setq evil-split-window-below t)
(setq +ivy-buffer-preview t)
(setq org-use-property-inheritance t)
(setq org-log-done 'time)
(setq org-list-allow-alphabetical t)
(setq org-export-in-background t)
(setq org-catch-invisible-edits 'error)

;;;;; spell
(remove-hook! '(org-mode-hook
               TeX-mode-hook
               rst-mode-hook
               mu4e-compose-mode-hook
               message-mode-hook
               git-commit-mode-hook
               prog-mode-hook
               text-mode-hook
               dired-mode-hook
               conf-mode-hook)
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
      modus-operandi-theme-alt-style t
      modus-operandi-theme-scale-5 1.9
      modus-operandi-theme-scale-4 1.6
      modus-operandi-theme-scale-3 1.3
      modus-operandi-theme-scale-2 1.1
      modus-operandi-theme-scale-1 1.0
      modus-operandi-theme-override-colors-alist '(("cyan-nuanced-bg" . "#fff3da") ("cyan-nuanced" . "#5d3026")
      ))

;;;;; modus-vivendi
(setq modus-vivendi-theme-bold-constructs t
      modus-vivendi-theme-slanted-constructs t
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
      modus-vivendi-theme-alt-style t
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
(setq doom-theme 'bb)

;;;; file loads
(load! "+functions.el")
(load! "+config.functions.el")
(load! "+custom.el")
(load! "+config.elfeed.el")

;;;; profiling
(let ((elapsed (float-time (time-subtract (current-time) t0))))
  (makunbound 't0)
  (message "spent %.3fs in config.el" elapsed))
;;;; end
