;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;;
(setq doom-font (font-spec :family "Fira Code" :size 18))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(add-hook! python-mode
           poetry-tracking-mode)

(defvar +richard/project-path
  "~/code"
  "Directory of projects")

(defun +richard/add-known-projects ()
  (if (file-directory-p +richard/project-path)
      (cl-loop for project-name in (directory-files +richard/project-path)
               do (projectile-add-known-project (expand-file-name project-name +richard/project-path)))
    (warn! "Project path '%s' has not been created!" (file-relative-name +richard/project-path "~"))))

(map!
 :map elixir-mode-map
 :localleader
 (:prefix ("c" . "code")
  :desc "Expand macro once (line)" :nv "m" #'alchemist-macroexpand-once-current-line
  :desc "Expand macro once (region)" :nv "M" #'alchemist-macroexpand-once-current-region
  :desc "Compile" :nv "c" #'alchemist-compile
  :desc "Compile current file" :nv "f" #'alchemist-compile-file
  :desc "Compile current buffer" :nv "b" #'alchemist-compile-this-buffer)
 (:prefix ("f" . "file")
  :desc "Toggle between file/tests" :nv "t" #'alchemist-project-toggle-file-and-tests
  :desc "Create file in project" :nv "c" #'alchemist-project-create-file)
 (:prefix ("h" . "help")
  :desc "Search hex" :nv "s" #'alchemist-hex-search
  :desc "List dependencies" :nv "l" #'alchemist-hex-all-dependencies)
 (:prefix ("r" . "repl")
  :desc "iex" :nv "i" #'alchemist-iex-run
  :desc "iex -S mix" :nv "p" #'alchemist-iex-project-run
  :desc "Compile buffer in IEx" :nv "b" #'alchemist-iex-compile-this-buffer-and-go
  :desc "Compile region in IEx" :nv "r" #'alchemist-iex-send-region-and-go)
 (:prefix ("m" . "mix")
  :desc "mix" :nv "x" #'alchemist-mix
  :desc "mix compile" :nv "c" #'alchemist-mix-compile
  :desc "mix run" :nv "r" #'alchemist-mix-run)
 (:prefix ("p" . "project")
  :desc "Find test" :nv "f" #'alchemist-project-find-test)
 (:prefix ("t" . "test")
  :nv "" nil
  :desc "mix test" :nv "a" #'alchemist-mix-test
  :desc "Toggle report" :nv "d" #'alchemist-test-toggle-test-report-display
  :desc "List tests" :nv "t" #'alchemist-test-mode-list-tests
  :desc "Run test at point" :nv "." #'alchemist-mix-test-at-point
  :desc "Rerun last test" :nv "r" #'alchemist-mix-rerun-last-test
  :desc "Run stale tests" :nv "s" #'alchemist-mix-test-stale
  :desc "Test current buffer" :nv "b" #'alchemist-mix-test-this-buffer
  :desc "Test file" :nv "f" #'alchemist-mix-test-file
  :desc "Run tests for current file" :nv "F" #'alchemist-project-run-tests-for-current-file
  :desc "Jump to previous test" :nv "[" #'alchemist-test-mode-jump-to-previous-test
  :desc "Jump to next test" :nv "]" #'alchemist-test-mode-jump-to-next-test
  :desc "Interrupt test process" :nv "k" #'alchemist-report-interrupt-current-process))


(setq lsp-clients-elixir-server-executable
      "/Users/richard/.lsp/elixir/language_server.sh")

(after! projectile
  (+richard/add-known-projects))

(direnv-mode)
