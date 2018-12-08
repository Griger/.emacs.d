(require 'pretty-mode)
(global-pretty-mode t)

(pretty-deactivate-groups
 '(:equality :ordering :ordering-double :ordering-triple
             :arrows :arrows-twoheaded :punctuation
             :logic :sets :arithmetic-double :arithmetic))

(pretty-activate-groups
 '(:greek :sets))

(global-prettify-symbols-mode 1)
