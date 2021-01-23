;;; ~/.doom.d/+functions.el -*- lexical-binding: t; -*-

;;;;;;;;functions
;;;; timestamp
(defun timestamp ()
  "Insert string for the current time formatted like '2:34 PM' or 1507121460 https://emacs.stackexchange.com/questions/7250/in-org-mode-how-to-insert-timestamp-with-todays-date"
  (interactive)
  (insert (format-time-string "[%02y-%02m-%02d %02H:%02M:%02S] ")))

(defun timestamp-no-time ()
  "timestamp without time"
  (interactive)
  (insert (format-time-string "[%02y-%02m-%02d]")))

;;;; org-*
;;;;; org-id-*
(defun org-id-create-copy ()
  "org-id-get-create and then org-id-copy"
  (interactive)
  (org-id-get-create) (org-id-copy))

(defun org-id-paste ()
  "pasting the yanked id, prepended by id:"
  (interactive)
  (insert "id:")
  (evil-paste-after 1))

;;;;; org-insert-*
(defun org-insert-quote-c ()
  "insert quotes in org mode"
  (interactive)
  (setq org-insert-history "quote")
  (org-insert-structure-template org-insert-history)
  )

(defun org-insert-source-interactive-c (userlang)
  "insert source in org mode, with user input"
  (interactive "sLanguage? ")
  (setq org-insert-history (concat "src " userlang))
  (org-insert-structure-template org-insert-history)
  )

(defun org-insert-source-c ()
  "insert source in org mode"
  (interactive)
  (setq org-insert-history "src")
  (org-insert-structure-template org-insert-history)
  )

(defun org-insert-markdown-source-c ()
  "insert markdown source in org mode"
  (interactive)
  (setq org-insert-history "src markdown")
  (org-insert-structure-template org-insert-history)
  )

(defun org-insert-shell-source-c ()
  "insert shell source in org mode"
  (interactive)
  (setq org-insert-history "src shell")
  (org-insert-structure-template org-insert-history)
  )

(defun org-insert-use-history-c ()
  (interactive)
  (org-insert-structure-template org-insert-history)
  )

;;;;; org-id-*
(defun org-id-update-recursively-c ()
  "Get all files in `org-directory' recursively and update org IDs."
  (interactive)
  (org-id-update-id-locations
   (directory-files-recursively org-directory ".org")))

(defun org-id-update-46ca-recursively-c ()
  "Get all files in 46/ca recursively and update org IDs."
  (interactive)
  (let ((org-id-locations-file "/home/sys1/46/ca/.orgids")
        (recentf-used-hooks nil))
    (org-id-update-id-locations
     (directory-files-recursively "/home/sys1/46/ca"
                                  ".org"))))

;;;; evil-window-*
(defun evil-window-split-Cxb ()
  "Split and open buffer"
  (interactive)
  (+evil-window-split-a))
(defun evil-window-vsplit-Cxb ()
  "VSplit and open buffer"
  (interactive)
  (+evil-window-vsplit-a))

(defun evil-window-vsplit-left-c ()
  "split to the left"
  (interactive)
  (let ((evil-vsplit-window-right nil))
    (+evil-window-vsplit-a))
  )

(defun evil-window-split-below-c ()
  "split to the bottom"
  (interactive)
  (let ((evil-split-window-below t))
    (+evil-window-split-a))
  )

(defun evil-window-split-above-c ()
  "split to the top"
  (interactive)
  (let ((evil-split-window-below nil))
    (+evil-window-split-a))
  )

(defun evil-window-vsplit-right-c ()
  "split to the right"
  (interactive)
  (let ((evil-vsplit-window-right t))
    (+evil-window-vsplit-a))
  )

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split-Cxb
           evil-window-vsplit-Cxb)
  (+ivy/switch-buffer))

(defun evil-window-split-ff ()
  "Split and open find-file"
  (interactive)
  (+evil-window-split-a))
(defun evil-window-vsplit-ff ()
  "VSplit and open find-file"
  (interactive)
  (+evil-window-vsplit-a))
(defadvice! prompt-for-buffer-ff (&rest _)
  :after '(evil-window-split-ff evil-window-vsplit-ff) (counsel-find-file))

(defun evil-window-split-fr ()
  "Split and open recent-files"
  (interactive)
  (+evil-window-split-a))
(defun evil-window-vsplit-fr ()
  "VSplit and open recent-files"
  (interactive)
  (+evil-window-vsplit-a))
(defadvice! prompt-for-buffer-fr (&rest _)
  :after '(evil-window-split-fr evil-window-vsplit-fr) (counsel-recentf))

;;;; org
;;;;; org-contract
(defun org-contract-current-heading-move-backward-c ()
  "Contract current heading and move back"
  (interactive)
  (org-cycle 4)
  (outline-previous-visible-heading 1)
  (org-cycle 64)
  )

(defun org-contract-current-heading-move-forward-c ()
  "Contract current heading and move forward"
  (interactive)
  (org-cycle 4)
  (outline-next-visible-heading 1)
  (org-cycle 64)
  )

;;;;; org-merge
(defun org-merge-next-heading-c ()
  "Merge next heading in org-mode"
  (interactive)
  (outline-next-visible-heading 1)
  (execute-kbd-macro (kbd "<tab> d j"))
  (outline-previous-visible-heading 1)
  (execute-kbd-macro (kbd "<tab>"))
  )

(defun org-merge-previous-heading-c ()
  "Merge previous heading in org-mode"
  (interactive)
  (outline-previous-visible-heading 1)
  (execute-kbd-macro (kbd "d d p <tab> k"))
  (org-merge-next-heading-c)
  )

;;;;; org-id-create
(defun org-id-create (&optional pom)
  "Get the ID property of the entry at point-or-marker POM.
If POM is nil, do nothing.
Create an ID if none is present already."
  (interactive "P")
  (org-with-point-at (point)
    (let ((id (org-entry-get nil "ID")))
      (unless id
        (progn
          (setq id (org-id-new))
          (org-entry-put (point) "ID" id)
          (org-id-add-location id (or org-id-overriding-file-name (buffer-file-name (buffer-base-buffer))))
          id)))))

;;;; shell
(defun open-shell-split-c ()
  "Split window and open shell"
  (interactive)
  (evil-window-split)
  ( +vterm/here 0 )
  )

(defun open-shell-vsplit-c ()
  "Vsplit window and open shell"
  (interactive)
  (evil-window-vsplit)
  ( +vterm/here 0 )
  )

;;;; org-timelogrefile-*
(defun org-timelogrefile-base-c (givendate)
  (save-restriction
    (org-narrow-to-subtree)
    (write-region
     (concat "#+TITLE: " givendate "\n\n")
     nil (concat "/home/sys1/46/ca/time/" givendate ".org"))
    (write-region
     (point-min) (point-max)
     (concat "/home/sys1/46/ca/time/" givendate ".org") t)))

(defun org-timelogrefile-interactive-c (givendate)
  (interactive "sDate:")
  (org-timelogrefile-base-c givendate))

(defun org-timelogrefile-c ()
  (interactive)
  (back-to-indentation)
  (let ((givendate (concat
                    (evil-yank-characters (+ (point) 3) (+ (point) 5))
                    (evil-yank-characters (+ (point) 6) (+ (point) 8))
                    (evil-yank-characters (+ (point) 9) (+ (point) 11))
                    )))
    (org-timelogrefile-base-c givendate)))

;;;; throwtext / placetext
(defun pasteatend-otherwindow-c ()
  (interactive)
  (other-window 1)
  (evil-goto-line)
  (evil-paste-after 1)
  )

(defun throwtext-c ()
  (interactive)
  (evil-delete-char (mark) (point))
  (pasteatend-otherwindow-c))

(defun throwtext-save-c ()
  (interactive)
  (evil-delete-char (mark) (point))
  (save-buffer)
  (pasteatend-otherwindow-c))

(defun placetext-c ()
  (interactive)
  (evil-yank (mark) (point))
  (pasteatend-otherwindow-c))

(defun placetext-save-c ()
  (interactive)
  (evil-yank (mark) (point))
  (save-buffer)
  (pasteatend-otherwindow-c))

;;;; enable-writing-mode
(defun enable-writing-mode-c ()
  (interactive)
  (let ((mixed-pitch-set-height nil)
        (markdown-hide-markup-in-view-modes nil)
        (markdown-hide-markup nil))
    (markdown-mode)
    (setq markdown-hide-markup-in-view-modes nil)
    (setq markdown-hide-markup nil)
    (turn-off-smartparens-mode)
    (setq-local olivetti-body-width 64)
    (olivetti-mode)
    (mixed-pitch-mode)
    ))

(defun enable-writing-mode-with-focus-c ()
  (interactive)
  (let ((mixed-pitch-set-height nil)
        (markdown-hide-markup-in-view-modes nil)
        (markdown-hide-markup nil))
    (markdown-mode)
    (turn-off-smartparens-mode)
    (mixed-pitch-mode)
    (setq-local olivetti-body-width 64)
    (olivetti-mode)
    (focus-mode)
    ))

;;;; comments toggle
(defun hide/show-comments-toggle-c ()
  (interactive)
  (hide/show-comments)
  (hide/show-comments-toggle))

;;;; counsel-*
(defun counsel-fzf-other-dir-c ()
  (interactive)
  (counsel-fzf nil (counsel-read-directory-name "Find file in project: " counsel--fzf-dir)))

;;;; evil-e-*
(defun evil-e-prompt-c ()
  "Edit from ~"
  (interactive)
  (evil-ex "e ~/"))

;;;; project / find-file
(defun project-browse-c (dir browse-command &optional commandargs)
  "Traverse a file structure starting from DIR."
  (let ((default-directory (file-truename (expand-file-name dir))))
    (call-interactively
     (funcall browse-command commandargs))))

(defun find-file-in-46/org ()
  "Browse files from `46/org"
  (interactive)
  (project-browse-c "/home/sys1/46/org" 'projectile-find-file))

(defun find-text-in-46/org ()
  "Browse text from `46/org"
  (interactive)
  (project-browse-c "/home/sys1/46/org" '+default/search-project))

;;;; org
(defun org-down-element-c ()
  "Move to and expand the next heading"
  (interactive)
  (org-down-element)
  (outline-next-visible-heading 1))

;;;; misc
(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))

(defadvice! +lookup/dictionary-definition-lexic (identifier &optional arg)
  "Look up the definition of the word at point (or selection) using `lexic-search'."
  :override #'+lookup/dictionary-definition
  (interactive
   (list (or (doom-thing-at-point-or-region 'word)
             (read-string "Look up in dictionary: "))
         current-prefix-arg))
  (lexic-search identifier nil nil t))

;;;; transparency toggle
(defun toggle-transparency-c ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(97 . 97) '(100 . 100)))))

;;;; misc
(defun screenshot-png-c ()
  "Save a screenshot of the current frame as an PNG image.
Saves to a temp file and puts the filename in the kill ring."
  (interactive)
  (let* ((filename (make-temp-file "Emacs" nil ".png"))
         (data (x-export-frames nil 'png)))
    (with-temp-file filename
      (insert data))
    (kill-new filename)
    (message filename)))

(defun definition-in-split ()
  "VSplit and definition"
  (interactive)
  (+evil-window-vsplit-a)
  (+lookup/definition (doom-thing-at-point-or-region)))

;;;; modus-theme-switch
(defun modus-theme-switch-c ()
  "Switch modus-theme (vivendi and operandi)"
  (interactive)
  (let ((theme (car-safe custom-enabled-themes)))
    (if (eq theme 'modus-vivendi)
        (progn
          (mapc #'disable-theme custom-enabled-themes)
          (load-theme 'modus-operandi 'noconfirm))
      (progn
        (mapc #'disable-theme custom-enabled-themes)
        (load-theme 'modus-vivendi 'noconfirm)))))

;;;; custom-theme-switch
(defun custom-theme-switch-c ()
  "Switch custom themes (bb and bb-light)"
  (interactive)
  (let ((theme (car-safe custom-enabled-themes)))
    (if (eq theme 'bb)
        (progn
         (mapc #'disable-theme custom-enabled-themes)
         (load-theme 'bb-light 'noconfirm))
      (progn
         (mapc #'disable-theme custom-enabled-themes)
         (load-theme 'bb 'noconfirm)))))

;;;; deft
(defun deft-current-root-c ()
  "Run Deft in the current project root"
  (interactive)
  (let ((deft-directory (if (fboundp 'projectile-project-root)
                            (or (projectile-project-root) default-directory)
                          default-directory)))
    (deft)))

;;;; add word to dictionary
(defun add-word-to-pdic-c ()
  (interactive)
  (write-region (concat (doom-thing-at-point-or-region) "\n") nil ispell-personal-dictionary t 0)
  (message (concat "added " (doom-thing-at-point-or-region) " to personal dictionary")))

;;;; pandoc mode
(defun pandoc-mode-hydra ()
  (interactive)
  (progn
    (pandoc-mode)
    (pandoc-main-hydra/body)))

;;;; fill-column
(defun fill-column-c (fillwidth)
  (interactive "sWidth: ")
  (let ((fill-column fillwidth))
   (fill-paragraph t)))

;;;; convert to org timestamp
(defun convert-to-org-timestamp-c (start end)
  "Convert line to org-timestamp"
  (interactive "r")
  (let* ((end (- end 1))
         (fmt-time (concat (format-time-string
                            "[%y-%m-%d %H:%M:%S]"
                            (date-to-time
                             (buffer-substring-no-properties start end))))))
    (delete-region start end)
    (left-char)
    (insert fmt-time)))

;;;; kindle to org
(fset 'kindle-clippings-to-org-macro
      (save-excursion (kmacro-lambda-form [?d ?d ?$ ?d ?% ?O ?\s-p escape ?d ?s ?b ?O ?* ?  escape ?J ?o ?* ?* ?  escape ?J ?j ?^ ?d ?w ?d ?w ?l ?v ?e ?~ ?I ?* ?* ?* ?  escape ?w ?d ?w ?f ?| ?r return ?d ?w ?d ?w ?V ?  ?\; ?c ?o ?n ?v ?e ?r ?t return ?j ?d ?d ?V ?\C-s ?f ?n] 0 "%d")))

;;;; org-headings-equalize
(cl-defun org-headings-equalize ()
  "Delete only successive headings on same level that match the
current heading under cursor
file needs to be in org SHOWALL mode"
  (interactive)
  (let ((heading-text-current (nth 4 (org-heading-components)))
        (heading-level-current (nth 0 (org-heading-components)))
        (heading-changed-count 0))
    (while (outline-next-heading)
      (progn
        (if (= heading-level-current (nth 0 (org-heading-components)))
            (if (string-match heading-text-current (nth 4 (org-heading-components)))
                (progn
                  (kill-whole-line)
                  (cl-incf heading-changed-count))
              (progn
                (message (concat
                          "Deleted "
                          (number-to-string heading-changed-count)
                          " headings at level "
                          (number-to-string heading-level-current)
                          " with heading \""
                          heading-text-current
                          "\""))
                (cl-return-from org-headings-equalize)))))
      (progn
        (message (concat
                  "Deleted "
                  (number-to-string heading-changed-count)
                  " headings at level "
                  (number-to-string heading-level-current)
                  " with heading \""
                  heading-text-current
                  "\""))))))

;;;; scroll
(defun scroll-up-c ()
  (interactive)
  (evil-scroll-page-up 3))

(defun scroll-down-c ()
  (interactive)
  (evil-scroll-page-down 3))

;;;; mixed-pitch without height
(defun mixed-pitch-mode-height ()
  (interactive)
  (let ((mixed-pitch-set-height nil))
    (mixed-pitch-mode)))

;;;; custom-surround
(defun custom-surround (&optional repeatlast)
  "Surround region with string(s)"
  (interactive)
  (unless repeatlast
    (setq isnewline (read-string "Newline? (yy/nn/yn/ny): "))
    (setq beginphrase (read-string "Start: "))
    (setq endphrase (read-string "End: ")))
  (let ((start (region-beginning))
        (end (region-end))
        (nstart (string= (substring isnewline 0 1) "y"))
        (nend (string= (substring isnewline 1 2) "y")))
    (save-excursion
      (goto-char start)
      (insert (concat beginphrase (if nstart "\n")))
      (if nend
          (progn
            (goto-char (+ end 4))
            (insert (concat "\n" endphrase)))
        (progn
          (goto-char (+ end 1))
          (insert (concat endphrase)))))))

(defun custom-surround-previous ()
  "Use previous custom-surround phrases"
  (interactive)
  (custom-surround t))

;;;; git
;;;;; auto-commit
(defun git-auto-time-commit ()
  "adds everything and commits with the date as the commit message."
  (interactive)
  (let* ((rootdir (expand-file-name (vc-root-dir)))
         (committime (substring (shell-command-to-string "date +%Y-%m-%d-%H:%M:%S") 0 -1))
         (gitadd (concat "git -C \"" rootdir "\" add --all"))
         (gitcommit (concat "git -C \"" rootdir "\" commit -m \"" committime "\"")))
    (progn
     (message gitadd)
     (message gitcommit)
     (shell-command gitadd)
     (shell-command gitcommit))))

(defun git-prompt-commit ()
  "adds everything and commits with the commit message provided by the user."
  (interactive)
  (let* ((rootdir (expand-file-name (vc-root-dir)))
         (commitmsg (read-string "Commit Message: "))
         (gitadd (concat "git -C \"" rootdir "\" add --all"))
         (gitcommit (concat "git -C \"" rootdir "\" commit -m \"" commitmsg "\"")))
    (progn
     (message gitadd)
     (message gitcommit)
     (shell-command gitadd)
     (shell-command gitcommit))))

;;;; split org block
(defun org-split-block-c ()
  (interactive)
  (let* ((initpos (line-number-at-pos (point)))
         (bstartpos (line-number-at-pos
                     (save-excursion (search-backward "#+begin")))) ;;TODO use re-search-backwards
         (bdata (save-excursion
                  (goto-line bstartpos)
                  (substring (thing-at-point 'line t) 8 -1)))
         (btype (car (split-string bdata)))
         (barg (cdr (split-string bdata)))
         (hdata (save-excursion ;;has newline at end
                  (outline-previous-heading)
                  (buffer-substring-no-properties
                   (line-beginning-position)
                   (progn (forward-line 3) (line-beginning-position))))))
    (save-excursion
      (progn
        (end-of-line 0) (open-line 1) (forward-line) ;;new line above
        (insert (concat "#+end_" btype))
        (end-of-line) (open-line 2) (forward-line 2) ;;2 new lines below
        (insert hdata)
        (insert (concat "#+start_" btype barg))))
    (goto-line (+ 1 initpos))))

;;;; sexp
(defun escape-sexp ()
  (interactive)
  (sp-forward-sexp)
  (forward-char))

(defun escape-sexp-backwards ()
  (interactive)
  (sp-backward-sexp)
  (backward-char))

;;; end
