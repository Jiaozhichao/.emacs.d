;;; init-ui.el --- settings for the Emacs UI

;;; Commentary:
;;; (c) Cabins, github.com/cabins/.emacs.d

    ;;; Code:

(set-frame-parameter nil 'alpha 0.96)

;; ;; Settings for UI theme
(use-package doom-themes
  :init (load-theme 'doom-one t))
  
(use-package smart-mode-line
 :init
 (setq sml/no-confirm-load-theme t
       sml/theme 'respectful)
 (sml/setup))

;; Function to set monofonts
(defun cabins/set-monospaced-font (english chinese e-size c-size)
  "cabins/set-monospaced-font is used for setting monospaced font"
  (set-face-attribute 'default nil
                      :font (font-spec
                             :name english
                             :weight 'normal
                             :slant 'normal
                             :size e-size))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec
                       :name chinese
                       :weight 'normal
                       :slant 'normal
                       :size c-size))))

(when (display-graphic-p)
  (if *is-windows*
      ;; font setting for Windows platform
      (cabins/set-monospaced-font "Courier New" "Microsoft Yahei Mono" 15 15))
  (if *is-mac*
      ;; font setting for macOS platform
      (cabins/set-monospaced-font "Monaco" "Helvetica" 13 13))
  (if *is-linux*
      ;; font setting for GNU/Linux platform
      (cabins/set-monospaced-font "Monaco" "Helvetica" 13 13))
  )


;; Font settings
(use-package emacs
  :when (display-graphic-p)
  :config
  (set-default 'cursor-type 'bar)
  ;; I prefer the cursor be red color, 'cause it's more obvious.
  (set-face-background 'cursor "#FF0000")
  (setq-default scroll-up-aggressively 0.01
                scroll-down-aggressively 0.01)
  (setq default-frame-alist '((width . 180) (height . 40)))
  (setq redisplay-dont-pause t
        scroll-conservatively most-positive-fixnum
        scroll-margin 1
        scroll-step 1
        scroll-preserve-screen-position 'always)
)

;; Theme settings
;;(use-package gruvbox-theme
;;  :init (load-theme 'gruvbox-dark-soft t))

;; Line number setting
(setq display-line-number-type 'relative) 
(global-display-line-numbers-mode t)

(use-package maple-minibuffer
  :ensure nil
  :hook (after-init . maple-minibuffer-mode)
  :config
  (setq maple-minibuffer:position-type 'window-center
        maple-minibuffer:border-color "gray50"
        maple-minibuffer:height nil
        maple-minibuffer:width 0.3
        maple-minibuffer:cache t)

  (setq maple-minibuffer:action '(read-from-minibuffer read-string)
        maple-minibuffer:ignore-action '(evil-ex eval-expression))

  (add-to-list 'maple-minibuffer:ignore-action 'org-schedule)
  (add-to-list 'maple-minibuffer:ignore-regexp "^helm-")

  ;; more custom parameters for frame
  (defun maple-minibuffer:parameters ()
    "Maple minibuffer parameters."
    `((height . ,(or maple-minibuffer:height 10))
      (width . ,(or maple-minibuffer:width (window-pixel-width)))
      (left-fringe . 5)
      (right-fringe . 5))))


(provide 'init-ui)
;;; init-ui.el ends here
