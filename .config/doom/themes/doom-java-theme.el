;;; doom-java-theme.el --- inspired by java -*- no-byte-compile: t; -*-
(require 'doom-themes)

;;
(defgroup doom-java-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-java-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-java-theme
  :type 'boolean)

(defcustom doom-java-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-java-theme
  :type 'boolean)

(defcustom doom-java-comment-bg doom-java-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-java-theme
  :type 'boolean)

(defcustom doom-java-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-java-theme
  :type '(choice integer boolean))

(eval-and-compile
  (defcustom doom-java-region-highlight t
    "Determines the selection highlight style. Can be 'frost, 'snowstorm or t
(default)."
    :group 'doom-java-theme
    :type 'symbol))

;;
(def-doom-theme doom-java
  "A dark theme inspired by java."

  ;; name        default   256       16
  ((bg         '("#30333d" nil       nil            ))
   (bg-alt     '("#30333d" nil       nil            ))
   (base0      '("#191C25" "black"   "black"        ))
   (base1      '("#292b34" "#1e1e1e" "brightblack"  ))
   (base2      '("#2C333F" "#2e2e2e" "brightblack"  ))
   (base3      '("#373E4C" "#262626" "brightblack"  ))
   (base4      '("#434C5E" "#3f3f3f" "brightblack"  ))
   (base5      '("#4C566A" "#525252" "brightblack"  ))
   (base6      '("#9099AB" "#6b6b6b" "brightblack"  ))
   (base7      '("#D8DEE9" "#979797" "brightblack"  ))
   (base8      '("#F0F4FC" "#dfdfdf" "white"        ))
   (fg         '("#ECEFF4" "#ECECEC" "white"        ))
   (fg-alt     '("#ffffff" "#bfbfbf" "brightwhite"  ))

   (grey       base4)
   (red        '("#f9929b" "#ff6655" "red"          )) ;; java11
   (orange     '("#fca2aa" "#dd8844" "brightred"    )) ;; java12
   (green      '("#7ed491" "#99bb66" "green"        )) ;; java14
   (teal       '("#a5d4af" "#44b9b1" "brightgreen"  )) ;; java7
   (yellow     '("#fbdf90" "#ECBE7B" "yellow"       )) ;; java13
   (blue       '("#bac8ef" "#51afef" "brightblue"   )) ;; java9
   (dark-blue  '("#a3b8ef" "#2257A0" "blue"         )) ;; java10
   (magenta    '("#ccaced" "#c678dd" "magenta"      )) ;; java15
   (violet     '("#d7c1ed" "#a9a1e1" "brightmagenta")) ;; ??
   (cyan       '("#c7e5d6" "#46D9FF" "brightcyan"   )) ;; java8
   (dark-cyan  '("#9ce5c0" "#5699AF" "cyan"         )) ;; ??

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.2))
   (selection      dark-blue)
   (builtin        blue)
   (comments       (if doom-java-brighter-comments dark-cyan (doom-lighten base5 0.2)))
   (doc-comments   (doom-lighten (if doom-java-brighter-comments dark-cyan base5) 0.25))
   (constants      blue)
   (functions      teal)
   (keywords       blue)
   (methods        teal)
   (operators      blue)
   (type           teal)
   (strings        green)
   (variables      base7)
   (numbers        magenta)
   (region         (pcase doom-java-region-highlight
                     (`frost teal)
                     (`snowstorm base7)
                     (_ base4)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-java-brighter-modeline)
   (-modeline-pad
    (when doom-java-padded-modeline
      (if (integerp doom-java-padded-modeline) doom-java-padded-modeline 4)))

   (region-fg
    (when (memq doom-java-region-highlight '(frost snowstorm))
      bg-alt))

   (modeline-fg     nil)
   (modeline-fg-alt base6)

   (modeline-bg
    (if -modeline-bright
        (doom-blend bg base5 0.2)
      base1))
   (modeline-bg-l
    (if -modeline-bright
        (doom-blend bg base5 0.2)
      `(,(doom-darken (car bg) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   (doom-darken bg 0.1))
   (modeline-bg-inactive-l `(,(car bg) ,@(cdr base1))))


  ;; --- extra faces ------------------------
  (((region &override) :foreground region-fg)

   ((line-number &override) :foreground (doom-lighten 'base5 0.2))
   ((line-number-current-line &override) :foreground base7)
   ((paren-face-match &override) :foreground red :background base3 :weight 'ultra-bold)
   ((paren-face-mismatch &override) :foreground base3 :background red :weight 'ultra-bold)
   ((vimish-fold-overlay &override) :inherit 'font-lock-comment-face :background base3 :weight 'light)
   ((vimish-fold-fringe &override)  :foreground teal)

   (font-lock-comment-face
    :foreground comments
    :background (if doom-java-comment-bg (doom-lighten bg 0.05)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))

   (doom-modeline-project-root-dir :foreground base6)
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;; ediff
   (ediff-fine-diff-A    :background (doom-darken violet 0.4) :weight 'bold)
   (ediff-current-diff-A :background (doom-darken base0 0.25))

   ;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))

   ;; org-mode
   (org-hide :foreground hidden)
   (solaire-org-hide-face :foreground hidden))


  ;; --- extra variables ---------------------
  ()
  )

;;; doom-java-theme.el ends here
