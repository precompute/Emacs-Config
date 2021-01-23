;;; custom/rss/config.el -*- lexical-binding: t; -*-

;; This is an opinionated workflow that turns Emacs into an RSS reader, inspired
;; by apps Reeder and Readkit. It can be invoked via `=rss'. Otherwise, if you
;; don't care for the UI you can invoke elfeed directly with `elfeed'.

(defvar +rss-split-direction 'below
  "What direction to pop up the entry buffer in elfeed.")

;;;; Packages

(use-package! elfeed
  :commands elfeed
  :init
  (defface elfeed-show-title-face '((t (:weight bold :height 1.2)))
    "title face in elfeed show buffer"
    :group 'elfeed)
  (defface elfeed-show-author-face `((t (:weight bold)))
    "title face in elfeed show buffer"
    :group 'elfeed)
  (defface elfeed-show-feed-face `((t (:weight bold)))
    "title face in elfeed show buffer"
    :group 'elfeed)
  (defface elfeed-show-tag-face `((t (:weight normal)))
    "tag face in elfeed show buffer"
    :group 'elfeed)
  (defface elfeed-show-misc-face `((t (:weight light)))
    "tag face in elfeed show buffer"
    :group 'elfeed)

  :config
  ;; (elfeed-goodies/setup)
  (setq elfeed-search-filter "+unread "
        elfeed-db-directory (concat doom-private-dir "elfeed/db/")
        elfeed-enclosure-default-dir (concat doom-private-dir "elfeed/enclosures/")
        elfeed-search-print-entry-function 'elfeed-search-print-entry-titlelast
        elfeed-search-title-max-width 500
        elfeed-search-title-min-width 5
        elfeed-search-feed-max-width 25
        elfeed-search-feed-min-width 25
        elfeed-search-tag-max-width 27
        elfeed-search-tag-min-width 27
        elfeed-search-trailing-width 0
        elfeed-show-entry-switch #'pop-to-buffer
        elfeed-show-entry-delete #'+rss/delete-pane
        elfeed-search-date-format '("\|%y%m%d%H%M" 10 :right)
        shr-max-image-proportion 0.6)
  (make-directory elfeed-db-directory t)

  ;; Ensure elfeed buffers are treated as real
  (push (lambda (buf) (string-match-p "^\\*elfeed" (buffer-name buf)))
        doom-real-buffer-functions)

  (set-popup-rule! "\\*elfeed-xwidget-webkit*" :side 'bottom :height 40 :select t)
  (set-popup-rule! "\\*elfeed-entry\\*$" :side 'left :width 80 :select t :modeline nil :quit t)
  ;; Enhance readability of a post
  (add-hook! 'elfeed-show-mode-hook
    (+rss|elfeed-wrap)
    (hide-mode-line-mode 1)
    (mixed-pitch-mode 1))

  (after! elfeed-search
    (setq-hook! '(elfeed-search-update-hook)
      truncate-lines t
      display-line-numbers t)
    (map! :map elfeed-search-mode-map
          [remap kill-this-buffer] "q"
          [remap kill-buffer] "q"
          :n doom-leader-key nil
          :nv "q" #'+rss/quit
          :nv "r" #'elfeed-update
          :nv "R" #'elfeed-update-feed
          :nv "s" #'elfeed-search-live-filter
          :nv "RET" #'elfeed-search-show-entry
          :nv "+" #'elfeed-search-tag-all
          :nv "-" #'elfeed-search-untag-all
          :nv "S" #'elfeed-search-set-filter
          :nv "o" #'elfeed-search-browse-url
          :nv "Y" #'elfeed-search-yank
          :nv "z" #'elfeed-search-mark-read
          :nv "Z" #'elfeed-search-star
          )
    ;; avoid ligature hang
    (advice-add #'elfeed-search--header-1 :override #'+rss/elfeed-search--header-1)
    (advice-add #'elfeed-show-next :override #'+rss/elfeed-show-next)
    (advice-add #'elfeed-show-prev :override #'+rss/elfeed-show-prev)
    )

  (after! elfeed-show
    (map! :map elfeed-show-mode-map
          [remap kill-this-buffer] "q"
          [remap kill-buffer] "q"
          :n doom-leader-key nil
          :nv "q" #'+rss/delete-pane
          :nv "o" #'ace-link-elfeed
          :nv "RET" #'org-ref-elfeed-add
          :nv "n" #'elfeed-show-next
          :nv "p" #'elfeed-show-prev
          :nv "+" #'elfeed-show-tag
          :nv "-" #'elfeed-show-untag
          :nv "s" #'elfeed-show-new-live-search
          :nv "Y" #'elfeed-show-yank
          :nv "z" #'elfeed-show-mark-read
          :nv "Z" #'elfeed-show-star
          )
    (advice-add #'elfeed-show-entry :override #'+rss/elfeed-show-entry)
    )

  (elfeed-org)
  )

(add-hook! 'elfeed-show-mode-hook 'mixed-pitch-mode)

(after! elfeed-search
  (set-evil-initial-state! 'elfeed-search-mode 'normal))
(after! elfeed-show-mode
  (set-evil-initial-state! 'elfeed-show-mode   'normal))

(after! evil-snipe
  (push 'elfeed-show-mode   evil-snipe-disabled-modes)
  (push 'elfeed-search-mode evil-snipe-disabled-modes))

;;;; Elfeed-org
(use-package! elfeed-org
  :commands (elfeed-org)
  :config
  (setq rmh-elfeed-org-files '("~/.doom.d/feed.org")))
