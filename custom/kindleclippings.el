;;; kindleclippings.el --- convert kindle clippings to org -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2020 sys1
;;
;; Author: sys1 <http://github/sys1>
;; Maintainer: sys1 <sys1@debhost1>
;; Created: September 16, 2020
;; Modified: September 18, 2020
;; Version: 0.0.2
;; Keywords:
;; Homepage: https://github.com/sys1/kindleclippings
;; Package-Requires: ((emacs 28.0.50) (cl-lib "0.5"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;; Convert kindle clippings to org file.
;; change encoding of file first (yes you, pebkac!)
;; It requires evil because the kill ring is retarded and petulant.
;; It does not, surprisingly, require org-mode. Ironic.
;;
;; [20-09-17 00:18:28]
;; Processed 54 kindle headings in 0.569s seconds.
;; Decent.
;;
;; [20-09-17 00:21:27]
;; Processed 1664 kindle headings in 34.760 seconds.
;; WOW.
;; The macro took ages! like an hour!
;;
;; [20-09-17 00:56:10]
;; Processed 5792 kindle headings in 411.565 seconds.
;; wew
;;
;;; Changes
;; 0.0.2  [20-09-18 09:59:50]  Replace next-line by forward-line
;; 0.0.1  [20-09-16]           Inital
;;
;;; Code:

;;;; variables

;;;; functions

;;;;; kindle-clippings-to-org
;;;###autoload
(defun kindle-clippings-to-org ()
  (interactive)
  (save-excursion
    (progn
      (narrow-to-region (point-at-bol) (search-forward-regexp "^==========" nil t 1))
      (evil-delete-whole-line (point-at-bol) (point-at-eol))
      (goto-char (point-min))
      (if (eq ?\) (char-after (- (point-at-eol) 1)))
          (progn
            (goto-char (- (point-at-eol) 1)) (delete-char 1)
            (goto-char (search-backward "(" nil t 1)) (delete-char 1) (insert "\n")
            (insert "* ")
            (goto-char (point-min)) (insert "** ")
            (evil-delete-whole-line (point-at-bol) (+ 1 (point-at-eol)))
            (evil-open-below 1)
            (evil-paste-after 1)
            (evil-delete-whole-line (point-at-bol) (+ 1 (point-at-eol))))
        (progn
          (insert "* ")
          (forward-line)))
      (goto-char (point-at-bol))
      (delete-region (point-at-bol) (search-forward " " nil t 2))
      (if (eq 2 (line-number-at-pos))
          (insert "** ")
        (insert "*** "))
      (upcase-word 1)
      (kill-word 2)
      (goto-char (- (search-forward "|" nil t 1) 1))
      (delete-char 3)
      (insert "\n")
      (kill-word 2)
      (insert "\n")
      (kindle-clippings-convert-to-org-timestamp (point-at-bol) (point-at-eol))
      (forward-line)
      (evil-delete-whole-line (point-at-bol) (+ 1 (point-at-eol)))
      (insert "#+begin_quote")
      (goto-char (point-max))
      (insert "#+end_quote")
      (widen)
      ;; (evil-normal-state) ;;SPEED
      )))

;;;;; kindle-clippings-to-org-until-eof
;;;###autoload
(defun kindle-clippings-to-org-until-eof ()
  (interactive)
  (setq-local kindle-headings 0)
  (setq-local kindle-clippings-time (current-time))
  (while (not (eobp))
    (progn
      (kindle-clippings-to-org)
      (incf kindle-headings)
      (goto-char (search-forward "end_quote" nil t 1))
      (forward-line)))
  (setq-local kindle-clippings-time
              (float-time (time-subtract (current-time) kindle-clippings-time)))
  (message "Processed %s kindle headings in %.3f seconds."
           kindle-headings
           kindle-clippings-time)
  (evil-normal-state))

;;;;; kindle-clippings-convert-to-org-timestamp
(defun kindle-clippings-convert-to-org-timestamp (start end)
  "Convert line to org-timestamp"
  (interactive "r")
  (let ((fmt-time (concat (format-time-string
                           "[%y-%m-%d %H:%M:%S]"
                           (date-to-time
                            (buffer-substring-no-properties start end))))))
    (delete-region start end)
    (left-char)
    (insert fmt-time)))

;;; end
