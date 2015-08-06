;;; ac-alchemist.el --- auto-complete source for alchemist -*- lexical-binding: t; -*-

;; Copyright (C) 2015 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>
;; URL: https://github.com/syohex/emacs-ac-alchemist
;; Version: 0.01
;; Package-Requires: ((auto-complete "1.5.0") (alchemist "0"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'auto-complete)
(require 'alchemist)
(require 'alchemist-complete)

(defgroup ac-alchemist nil
  ""
  :group 'auto-complete)

(defvar ac-alchemist--cache nil)
(defvar ac-alchemist--prefix nil)
(defvar ac-alchemist--document nil)

(defun ac-alchemist--candidates ()
  (cl-loop for cand in ac-alchemist--cache
           when (string-match "\\(\\S-+\\)\\(/[0-9]+\\)" cand)
           collect
           (popup-make-item (match-string-no-properties 1 cand)
                            :symbol (match-string-no-properties 2 cand))))

(defun alchemist--complete-filter (_process output)
  (when (alchemist-server-contains-end-marker-p output)
    (let ((candidates (with-temp-buffer
                        (insert output)
                        (goto-char (point-min))
                        (let ((cs nil))
                          (while (not (looking-at-p "^END"))
                            (push (buffer-substring-no-properties
                                   (+ (line-beginning-position) 4) ;; remove 'cmp:'
                                   (line-end-position)) cs)
                            (forward-line 1))
                          (reverse cs)))))
      (setq ac-alchemist--cache candidates)
      (auto-complete))))

;;;###autoload
(defun ac-alchemist-complete ()
  (interactive)
  (let ((prefix (save-excursion
                  (let ((end (point)))
                    (skip-chars-backward "[a-zA-Z._]")
                    (buffer-substring-no-properties (point) end)))))
    (setq ac-alchemist--prefix prefix)
    (alchemist-server-complete-candidates
     (format "%s;[];[]" prefix)
     'alchemist--complete-filter)))

(defun alchemist-company-doc-buffer-filter (_process output)
  (when (alchemist-server-contains-end-marker-p output)
    (let ((docstr (alchemist--utils-clear-ansi-sequences
                   (alchemist-server-prepare-filter-output (list output)))))
      (setq ac-alchemist--document docstr))))

(defun ac-alchemist--show-document (candidate)
  (let* ((arity (or (get-text-property 0 'symbol candidate) ""))
         (query (alchemist-help--prepare-search-expr
                 (concat ac-alchemist--prefix candidate arity))))
    (setq alchemist-company-doc-lookup-done nil)
    (alchemist-server-help
     (alchemist-help--server-arguments query)
     'alchemist-company-doc-buffer-filter)
    (sit-for 0.05)
    ac-alchemist--document))

(defun ac-alchemist--prefix ()
  (when (looking-back "[a-zA-Z._]" (line-beginning-position))
    (point)))

(ac-define-source alchemist
  `((prefix . ac-alchemist--prefix)
    (candidates . ac-alchemist--candidates)
    (document . ac-alchemist--show-document)
    (requires . -1)))

(provide 'ac-alchemist)

;;; ac-alchemist.el ends here
