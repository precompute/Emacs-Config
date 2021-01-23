;;; refile2.el --- description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2020 sys1
;;
;; Author: sys1 <http://github/sys1>
;; Maintainer: sys1 <sys1@debhost1>
;; Created: September 08, 2020
;; Modified: December 22, 2020
;; Version: 0.0.4
;; Keywords:
;; Homepage: https://github.com/sys1/refile2
;; Package-Requires: ((emacs 28.0.50) (cl-lib "0.5"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Alternative to customrefile, uses =fd= instead of =projectile=. Does not
;;  have nay weird edge cases and should work properly this time. Unless it
;;  overwrites some major partition because of no error checking or something,
;;  it should be okay.
;;
;;  December 18 2020:
;;  Adds current folder relative / vc root dir relative refiling

;;  December 20 2020: (0.0.3)
;;  Changed starting template to include Level one heading.
;;  Capitalized default file names.
;;  removed relative prepend from functions that use vc-root.

;;  December 22 2020: (0.0.4)
;;  Added id creation to *-copy
;;; Code:

;;;; flags
;;;;; settings
(defvar refile2-common-file
  "Inbox.org"
  "The default file to be written to for every directory")

(defvar refile2-link-file
  "Links.org"
  "The default file to which links are written to")

(defvar refile2-common-file-snippet "* Inbox.org\n#+STARTUP: overview\n"
  "String to be inserted into every file created by this program")

(defvar refile2-link-file-snippet "* Links.org\n#+TITLE: links\n#+STARTUP: overview\n"
  "String to be inserted into every link file created by this program")

(defvar refile2-modified-list nil
  "List of files written to")

;;;;; convenience
(defvar refile2-binary "fd"
  "The location of the binary for the program. The default is fd")

(defvar refile2-flags
  "-c never -t d"
  "The flags used.If modified, the program wouldn't work short of major modifications.")

;;;; functions

;;;;; relative ivy-read
(defun refile2-relative-ivy-read ()
  "Uses default-directory"
  (interactive)
  (ivy-read (format "%s" default-directory)
            (split-string-and-unquote
             (shell-command-to-string (refile2-relative-dirlist-invocation)))))

;;;;; ivy-read
(defun refile2-ivy-read ()
  "Uses vc-root-dir. Make sure you are in a vc-root!"
  (interactive)
  (ivy-read (format "%s" (vc-root-dir))
            (split-string-and-unquote
             (shell-command-to-string (refile2-dirlist-invocation)))))

;;;;; relative args concat
(defun refile2-relative-dirlist-invocation ()
  (concat refile2-binary " "
          refile2-flags " "
          "--base-directory" " "
          default-directory))

;;;;; args concat
(defun refile2-dirlist-invocation ()
  (concat refile2-binary " "
          refile2-flags " "
          "--base-directory" " "
          (vc-root-dir)))

;;;;; relative copy headline
;;;###autoload
(defun refile2-relative-copy-headline ()
  "Copy headline under destination folder, relative context"
  (interactive)
  (save-restriction
    (org-narrow-to-subtree)
    (org-id-create)
    (let ((basedir (file-name-as-directory (refile2-relative-ivy-read))))
      (if (file-directory-p basedir)
          (progn
            (write-region "\n" nil (concat basedir refile2-common-file) t))
        (progn
          (make-directory basedir t)
          (write-region refile2-common-file-snippet nil (concat basedir refile2-common-file) t)))
      (evil-write (point-min) (point-max) nil (concat ">> " basedir refile2-common-file))
      (add-to-list 'refile2-modified-list (concat basedir refile2-common-file) t))
    (widen)))

;;;;; copy headline
;;;###autoload
(defun refile2-copy-headline ()
  "Copy headline under destination folder"
  (interactive)
  (save-restriction
    (org-narrow-to-subtree)
    (org-id-create)
    (let* ((basedir (file-name-as-directory (refile2-ivy-read)))
           (basedir (concat (vc-root-dir) basedir)))
      (if (file-directory-p basedir)
          (progn
            (write-region "\n" nil (concat basedir refile2-common-file) t))
        (progn
          (make-directory basedir t)
          (write-region refile2-common-file-snippet nil (concat basedir refile2-common-file) t)))
      (evil-write (point-min) (point-max) nil (concat ">> " basedir refile2-common-file))
      (add-to-list 'refile2-modified-list (concat basedir refile2-common-file) t))
    (widen)))

;;;;; relative link headline
;;;###autoload
(defun refile2-relative-link-headline (&optional context)
  "Link headline to (relative) destination folder. t if you wish to add context. (interactive)"
  (interactive)
  (save-restriction
    (org-narrow-to-subtree)
    (let ((basedir (file-name-as-directory (refile2-relative-ivy-read)))
          (org-heading-text (nth 4 (org-heading-components)))
          (org-id-text (org-id-get-create))
          (custom-context (if context
                              (read-string "Context: ")
                            nil)))
      (if (file-directory-p basedir)
          (progn
            (write-region "\n" nil (concat basedir refile2-link-file) t))
        (progn
          (make-directory basedir t)
          (write-region refile2-link-file-snippet nil (concat basedir refile2-link-file) t)))
      (write-region (concat
                     "** "
                     org-heading-text
                     "\n"
                     "*** "
                     "[[id:" org-id-text "]"
                     "[" (buffer-file-name) "]]"
                     "\n"
                     custom-context) nil (concat basedir refile2-link-file) t)
      (add-to-list 'refile2-modified-list (concat basedir refile2-link-file) t))
    (widen)))

;;;;;; +context
;;;###autoload
(defun refile2-relative-link-headline-with-context ()
  "Wrapper around refile2-relative-link-headline with context passed as t. (interactive)"
  (interactive)
  (refile2-relative-link-headline t))

;;;;; link headline
;;;###autoload
(defun refile2-link-headline (&optional context)
  "Link headline to destination folder. t if you wish to add context. (interactive)"
  (interactive)
  (save-restriction
    (org-narrow-to-subtree)
    (let* ((basedir (file-name-as-directory (refile2-ivy-read)))
          (basedir (concat (vc-root-dir) basedir))
          (org-heading-text (nth 4 (org-heading-components)))
          (org-id-text (org-id-get-create))
          (custom-context (if context
                              (read-string "Context: ")
                            nil)))
      (if (file-directory-p basedir)
          (progn
            (write-region "\n" nil (concat basedir refile2-link-file) t))
        (progn
          (make-directory basedir t)
          (write-region refile2-link-file-snippet nil (concat basedir refile2-link-file) t)))
      (write-region (concat
                     "** "
                     org-heading-text
                     "\n"
                     "*** "
                     "[[id:" org-id-text "]"
                     "[" (buffer-file-name) "]]"
                     "\n"
                     custom-context) nil (concat basedir refile2-link-file) t)
      (add-to-list 'refile2-modified-list (concat basedir refile2-link-file) t))
    (widen)))

;;;;;; +context
;;;###autoload
(defun refile2-link-headline-with-context ()
  "Wrapper around refile2-link-headline with context passed as t. (interactive)"
  (interactive)
  (refile2-link-headline t))

;;;;; refile2-modified-list

;;;;;; clean
;;;###autoload
(defun refile2-clean-modified-list ()
  "Clean refile2-modified-list"
  (interactive)
  (setq refile2-modified-list nil))

;;;;;; print (plain)
;;;###autoload
(defun refile2-print-modified-list ()
  "Print refile2-modified-list, newline delimited"
  (interactive)
  (let ((modified-list refile2-modified-list))
    (while (not (null modified-list))
      (insert (concat (pop modified-list) "\n")))))

;;;;;; print (checkboxed)
;;;###autoload
(defun refile2-print-checkboxes-modified-list ()
  "Print refile2-modified-list with checkboxes and org-style file links."
  (interactive)
  (let ((modified-list refile2-modified-list))
    (while (not (null modified-list))
      (insert (concat "- [ ] file:" (pop modified-list) "\n")))))

(provide 'refile2)
;;; refile2.el ends here
