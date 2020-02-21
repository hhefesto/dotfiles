;; hhefesto
;; hhefest@rdataa.com
;; Copyright: share and do what you wish

;; For some wierd reason multi-term works only after I delete it in list-packages and re-install.
;; I just changed the location of custom-set-variables, so maybe the problem is already resolved.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-startup-truncated nil)
 '(package-selected-packages
   (quote
    (flycheck dante markdown-mode yaml-mode nix-mode use-package ranger magit manage-minor-mode hasky-stack intero gruber-darker-theme smex web-mode php-mode hamlet-mode shakespeare-mode company tide ts-comint typescript-mode haskell-mode zenburn-theme zenburn yasnippet multi-term)))
 '(safe-local-variable-values
   (quote
    ((hamlet/basic-offset . 4)
     (haskell-process-use-ghci . t)
     (haskell-indent-spaces . 4)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 125 :family "Hack")))))

;; Why? require 'cl
(require 'cl)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/") t)
  (package-initialize)
  (package-refresh-contents))

(setq package-archive-enable-alist '(("melpa" deft magit)))

;; list the packages you want
(setq package-list '(gruber-darker-theme yasnippet multi-term haskell-mode smex intero))
;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))
;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(column-number-mode 1)

(if (eq system-type 'windows-nt)
    (set-face-attribute 'default (selected-frame) :height 132))

(setq inhibit-startup-message t)

(setq-default cursor-type 'bar)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(global-linum-mode 1)

(load-theme 'gruber-darker t)

(menu-bar-mode -1)
(tool-bar-mode -1)

(setq user-full-name "Daniel Herrera Rendón")
(setq user-mail-address "daniel.herrera.rendon@gmail.com")

(setq tab-width 2
      indent-tabs-mode nil)
(setq-default indent-tabs-mode nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(show-paren-mode t)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(ido-mode t)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t)

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (indent-buffer)
  (untabify-buffer)
  (delete-trailing-whitespace))

(defun cleanup-region (beg end)
  "Remove tmux artifacts from region."
  (interactive "r")
  (dolist (re '("\\\\│\·*\n" "\W*│\·*"))
    (replace-regexp re "" nil beg end)))

(global-set-key (kbd "C-x M-t") 'cleanup-region)
(global-set-key (kbd "C-c n") 'cleanup-buffer)

;; make whitespace-mode use just basic coloring
(setq whitespace-style (quote (spaces tabs newline space-mark tab-mark newline-mark)))

(setq whitespace-display-mappings
      ;; all numbers are Unicode codepoint in decimal. try (insert-char 182 ) to see it
      '(
        (space-mark 32 [183] [46]) ; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
        (newline-mark 10 [182 10]) ; 10 LINE FEED
        (tab-mark 9 [9655 9] [92 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
        ))
(global-whitespace-mode 1)

(setq flyspell-issue-welcome-flag nil)
;; (if (eq system-type 'darwin)
;;     (setq-default ispell-program-name "/usr/local/bin/aspell")
;;   (setq-default ispell-program-name "/usr/bin/aspell"))
(setq-default ispell-program-name "/run/current-system/sw/bin/aspell")
;; (setq-default ispell-list-command "list")

(add-to-list 'auto-mode-alist '("\\.zsh$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.zshrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("zshrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.sh$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.gitconfig$" . conf-mode))

(add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))

(defun my-export-to-parent ()
  "Exports the table in the current buffer back to its parent DSV file and
    then closes this buffer."
  (let ((buf (current-buffer)))
    (org-table-export parent-file export-func)
    (set-buffer-modified-p nil)
    (switch-to-buffer (find-file parent-file))
    (kill-buffer buf)))

(defun my-edit-dsv-as-orgtbl (&optional arg)
  "Convet the current DSV buffer into an org table in a separate file. Saving
    the table will convert it back to DSV and jump back to the original file"
  (interactive "P")
  (let* ((buf (current-buffer))
         (file (buffer-file-name buf))
         (txt (substring-no-properties (buffer-string)))
         (org-buf (find-file-noselect (concat (buffer-name) ".org"))))
    (save-buffer)
    (with-current-buffer org-buf
      (erase-buffer)
      (insert txt)
      (org-table-convert-region 1 (buffer-end 1) arg)
      (setq-local parent-file file)
      (cond
       ((equal arg '(4)) (setq-local export-func "orgtbl-to-csv"))
       ((equal arg '(16)) (setq-local export-func "orgtbl-to-tsv"))
       (t (setq-local export-func "orgtbl-to-tsv")))
      (add-hook 'after-save-hook 'my-export-to-parent nil t))
    (switch-to-buffer org-buf)
    (kill-buffer buf)))

;; Open the current TSV file as an Org table
(global-set-key (kbd "C-c |") 'my-edit-dsv-as-orgtbl)


                                        ; --------zsh--------
(setq multi-term-program "/bin/zsh")

(add-hook 'term-mode-hook
          (lambda ()
            (setq term-buffer-maximum-size 10000)))
(add-hook 'term-mode-hook
          (lambda ()
            (setq show-trailing-whitespace nil)))

(defcustom term-unbind-key-list
  '("C-z" "C-x" "C-c" "C-h" "C-y" "<ESC>")
  "The key list that will need to be unbind."
  :type 'list
  :group 'multi-term)

(defcustom term-bind-key-alist
  '(
    ("C-c C-c" . term-interrupt-subjob)
    ("C-p" . previous-line)
    ("C-n" . next-line)
    ("C-s" . isearch-forward)
    ("C-r" . isearch-backward)
    ("C-m" . term-send-raw)
    ("M-f" . term-send-forward-word)
    ("M-b" . term-send-backward-word)
    ("M-o" . term-send-backspace)
    ("M-p" . term-send-up)
    ("M-n" . term-send-down)
    ("M-M" . term-send-forward-kill-word)
    ("M-N" . term-send-backward-kill-word)
    ("M-r" . term-send-reverse-search-history)
    ("M-," . term-send-input)
    ("M-." . comint-dynamic-complete))
  "The key alist that will need to be bind.
If you do not like default setup, modify it, with (KEY . COMMAND) format."
  :type 'alist
  :group 'multi-term)

(add-hook 'term-mode-hook
          (lambda ()
            (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
            (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))
            (define-key term-raw-map (kbd "C-y") 'term-paste)
            (yas-minor-mode 0)
            (message "%s" "This is in term mode and hook enabled.")))

;; ;; --------eclim--------
;; (require 'eclim)
;; (global-eclim-mode)
;; (require 'eclimd)

;; (setq help-at-pt-display-when-idle t)
;; (setq help-at-pt-timer-delay 0.1)
;; (help-at-pt-set-timer)

;; ;; add the emacs-eclim source
;; (require 'ac-emacs-eclim-source)
;; (ac-emacs-eclim-config)

;; --------full screen--------
(defvar my-fullscreen-p t "Check if fullscreen is on or off")

(defun my-non-fullscreen ()
  (interactive)
  (if (fboundp 'w32-send-sys-command)
      ;; WM_SYSCOMMAND restore #xf120
      (w32-send-sys-command 61728)
    (progn (set-frame-parameter nil 'width 82)
           (set-frame-parameter nil 'fullscreen 'fullheight))))

(defun my-fullscreen ()
  (interactive)
  (if (fboundp 'w32-send-sys-command)
      ;; WM_SYSCOMMAND maximaze #xf030
      (w32-send-sys-command 61488)
    (set-frame-parameter nil 'fullscreen 'fullboth)))

(defun my-toggle-fullscreen ()
  (interactive)
  (setq my-fullscreen-p (not my-fullscreen-p))
  (if my-fullscreen-p
      (my-non-fullscreen)
    (my-fullscreen)))

(my-fullscreen)

;; --------autosaves not on .--------
(setq backup-directory-alist `(("." . "~/temp")))
(setq auto-save-file-name-transforms
      `((".*" ,"~/temp/" t)))


;;--------C--------
(require 'cc-mode)
;;(setq c-default-style "linux"
;;      c-basic-offset 4)
(setq-default c-indent-tabs-mode t     ; Pressing TAB should cause indentation
              c-indent-level 4         ; A TAB is equivilent to four spaces
              c-argdecl-indent 0       ; Do not indent argument decl's extra
              c-tab-always-indent t
              backward-delete-function nil) ; DO NOT expand tabs when deleting
;;(c-add-style "my-c-style" '((c-continued-statement-offset 4))) ; If a statement continues on the next line, indent the continuation by 4
(defun my-c-mode-hook ()
  (c-set-style "linux")
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open '0) ; brackets should be at same indentation level as the statements they open
  (c-set-offset 'inline-open '+)
  (c-set-offset 'block-open '+)
  (c-set-offset 'brace-list-open '+)   ; all "opens" should be indented by the c-indent-level
  (c-set-offset 'case-label '+))       ; indent case labels by c-indent-level, too
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

                                        ;--------Miscellaneous--------
;; (require 'yasnippet)
;; (add-to-list 'yas-snippet-dirs "~/.emacs.d/yasnippet-snippets")

;; (yas-global-mode 1)

;;(if (not (get-buffer "*terminal<1>*"))
;;    (multi-term))


;;--------Typescript--------
;;defun(defun setup-tide-mode ()
;; (interactive)
;;  (tide-setup)
;;  (flycheck-mode +1)
;;  (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;  (eldoc-mode +1)
;;  (tide-hl-identifier-mode +1)
;;  ;; company is an optional dependency. You have to
;;  ;; install it separately via package-install
;;  ;; `M-x package-install [ret] company`
;;  (company-mode +1))

;;;; aligns annotation to the right hand side
;;(setq company-tooltip-align-annotations t)

;;;; formats the buffer before saving
;;(add-hook 'before-save-hook 'tide-format-before-save)

;;(add-hook 'typescript-mode-hook #'setup-tide-mode)

;;-----------Haskell----------------

(add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)

;; (add-hook 'haskell-mode-hook 'intero-mode)

;; (setq intero-blacklist '("/home/hhefesto/dev/YesodEmailAuthBookExample/src/Main.hs"))
;; (add-hook 'haskell-mode-hook 'intero-mode-blacklist) ;; I added this because setq intero-blacklist isn't working properly
;; (intero-global-mode 1)

;; (use-package dante
;;   :ensure t
;;   :after haskell-mode
;;   :commands 'dante-mode
;;   :init
;;   (add-hook 'haskell-mode-hook 'flycheck-mode)
;;   ;; OR:
;;   ;; (add-hook 'haskell-mode-hook 'flymake-mode)
;;   (add-hook 'haskell-mode-hook 'dante-mode)
;;   )

;; (setq flymake-no-changes-timeout nil)
;; (setq flymake-start-syntax-check-on-newline nil)
;; (setq flycheck-check-syntax-automatically '(save mode-enabled))

;; (add-hook 'dante-mode-hook
;;    '(lambda () (flycheck-add-next-checker 'haskell-dante
;;                 '(warning . haskell-hlint))))

;; (setq intero-blacklist '("/home/hhefesto/src/YesodEmailAuthBookExample/" "/home/hhefesto/src/dotfiles" "/home/hhefesto/src/layer3com/layer3com" "/home/hhefesto/src/ejercicios-victor" "/home/hhefesto/src/log")) ;;"/home/hhefesto/src/stand-in-language"))

;;-----------Magit----------------
;; Getting startued tutorial at:
;; https://magit.vc/manual/magit/Getting-Started.html
(global-set-key (kbd "C-x g") 'magit-status)


;;           IRC
;; source: https://github.com/jwiegley/dot-emacs/blob/master/init.el#L1369 https://github.com/jwiegley/dot-emacs/blob/0e07f471036d6f3ec4f3cbd38fe3277be072747b/init.el

;; (use-package erc
;;              :commands (erc erc-tls)
;;              :bind (:map erc-mode-map
;;                          ("C-c r" . reset-erc-track-mode))
;;              :preface
;;              (defun irc (&optional arg)
;;                (interactive "P")
;;                (if arg
;;                    (pcase-dolist (`(,server . ,nick)
;;                                   '(("irc.freenode.net"     . "johnw")
;;                                     ("irc.gitter.im"        . "jwiegley")
;;                                     ;; ("irc.oftc.net"         . "johnw")
;;                                     ))
;;                      (erc-tls :server server :port 6697 :nick (concat nick "_")
;;                               :password (lookup-password server nick 6697)))
;;                  (let ((pass (lookup-password "irc.freenode.net" "johnw" 6697)))
;;                    (when (> (length pass) 32)
;;                      (error "Failed to read ZNC password"))
;;                    (erc :server "127.0.0.1" :port 6697 :nick "johnw"
;;                         :password (concat "johnw/gitter:" pass))
;;                    (sleep-for 5)
;;                    (erc :server "127.0.0.1" :port 6697 :nick "johnw"
;;                         :password (concat "johnw/freenode:" pass)))))

;;              (defun reset-erc-track-mode ()
;;                (interactive)
;;                (setq erc-modified-channels-alist nil)
;;                (erc-modified-channels-update)
;;                (erc-modified-channels-display)
;;                (force-mode-line-update))

;;              (defun setup-irc-environment ()
;;                (set (make-local-variable 'scroll-conservatively) 100)
;;                (setq erc-timestamp-only-if-changed-flag nil
;;                      erc-timestamp-format "%H:%M "
;;                      erc-fill-prefix "          "
;;                      erc-fill-column 78
;;                      erc-insert-timestamp-function 'erc-insert-timestamp-left
;;                      ivy-use-virtual-buffers nil))

;;              (defcustom erc-foolish-content '()
;;                "Regular expressions to identify foolish content.
;;     Usually what happens is that you add the bots to
;;     `erc-ignore-list' and the bot commands to this list."
;;                :group 'erc
;;                :type '(repeat regexp))

;;              (defun erc-foolish-content (msg)
;;                "Check whether MSG is foolish."
;;                (erc-list-match erc-foolish-content msg))

;;              :init
;;              (add-hook 'erc-mode-hook #'setup-irc-environment)
;;              (when alternate-emacs
;;                (add-hook 'emacs-startup-hook 'irc))

;;              (eval-after-load 'erc-identd
;;                '(defun erc-identd-start (&optional port)
;;                   "Start an identd server listening to port 8113.
;;   Port 113 (auth) will need to be redirected to port 8113 on your
;;   machine -- using iptables, or a program like redir which can be
;;   run from inetd. The idea is to provide a simple identd server
;;   when you need one, without having to install one globally on
;;   your system."
;;                   (interactive (list (read-string "Serve identd requests on port: " "8113")))
;;                   (unless port (setq port erc-identd-port))
;;                   (when (stringp port)
;;                     (setq port (string-to-number port)))
;;                   (when erc-identd-process
;;                     (delete-process erc-identd-process))
;;                   (setq erc-identd-process
;;                         (make-network-process :name "identd"
;;                                               :buffer nil
;;                                               :host 'local :service port
;;                                               :server t :noquery t
;;                                               :filter 'erc-identd-filter))
;;                   (set-process-query-on-exit-flag erc-identd-process nil)))

;;              :config
;;              (erc-track-minor-mode 1)
;;              (erc-track-mode 1)

;;              (add-hook 'erc-insert-pre-hook
;;                        #'(lambda (s)
;;                            (when (erc-foolish-content s)
;;                              (setq erc-insert-this nil)))))

;; (use-package erc-alert
;;              :disabled t
;;              :after erc)

;; (use-package erc-highlight-nicknames
;;              :after erc)

;; (use-package erc-macros
;;              :after erc)

;; (use-package erc-patch
;;              :disabled t
;;              :after erc)

;; (use-package erc-question
;;              :disabled t
;;              :after erc)

;; (use-package erc-yank
;;              :load-path "lisp/erc-yank"
;;              :after erc
;;              :bind (:map erc-mode-map
;;                          ("C-y" . erc-yank )))

;; (setenv "PATH" (concat (getenv "PATH") ":/run/current-system/sw/bin/"))
;; (setq exec-path (append exec-path '("/run/current-system/sw/bin/")))
;; (setq ispell-program-name "/run/current-system/sw/bin/aspell")
;; (add-to-list 'exec-path "/run/current-system/sw/bin/")
