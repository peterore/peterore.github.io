;; Set package installation directory
;;;; this is exclusive to the website --- no leakage to/from my personal config
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

(message "Jacked up n' good to go")

;; Customize html output
(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />\n<link rel=\"stylesheet\" href=\"./custom.css\" />")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "my-org-site"
	     :recursive t
	     :base-directory "./content"
	     :publishing-directory "./public"
	     :publishing-function 'org-html-publish-to-html
	     :with-author nil
	     :with-creator nil
	     :with-toc nil
	     :section-numbers nil
	     :time-stamp-file t)
       (list "my-org-static"
	     :recursive t
	     :base-directory "./content"
	     :base-extension "css\\|js\\|png\\|jpg\\|jpeg\\|gif\\|pdf\\|svg"
	     :publishing-directory "./public"
	     :publishing-function 'org-publish-attachment)
       ))

;; Generate the site output
(org-publish-all t)

(message "Job's finished")

;; Built from the systemcrafters tutorial: https://systemcrafters.net/publishing-websites-with-org-mode/building-the-site/
