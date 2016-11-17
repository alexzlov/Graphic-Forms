;;; -*- Mode: Lisp -*-

;;;;
;;;; graphic-forms-uitoolkit.asd
;;;;
;;;; Copyright (C) 2006-2007, Jack D. Unrue
;;;; Copyright (C) 2016, Bo Yao <icerove@gmail.com>
;;;; All rights reserved.
;;;;
;;;; Redistribution and use in source and binary forms, with or without
;;;; modification, are permitted provided that the following conditions
;;;; are met:
;;;; 
;;;;     1. Redistributions of source code must retain the above copyright
;;;;        notice, this list of conditions and the following disclaimer.
;;;; 
;;;;     2. Redistributions in binary form must reproduce the above copyright
;;;;        notice, this list of conditions and the following disclaimer in the
;;;;        documentation and/or other materials provided with the distribution.
;;;; 
;;;;     3. Neither the names of the authors nor the names of its contributors
;;;;        may be used to endorse or promote products derived from this software
;;;;        without specific prior written permission.
;;;; 
;;;; THIS SOFTWARE IS PROVIDED BY THE AUTHORS AND CONTRIBUTORS "AS IS" AND ANY
;;;; EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;;;; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DIS-
;;;; CLAIMED.  IN NO EVENT SHALL THE AUTHORS AND CONTRIBUTORS BE LIABLE FOR ANY
;;;; DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
;;;; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
;;;; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
;;;; ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;;;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;;;; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;;;;

(defsystem graphic-forms-uitoolkit
  :description "Graphic-Forms UI Toolkit"
  :depends-on ("cffi"
	       "lw-compat"
	       "closer-mop"
	       "com.gigamonkeys.macro-utilities"
	       "com.gigamonkeys.binary-data")
  :components
  ((:file "config")
   (:module "src"
	    :depends-on "config"
	    :components
	    ((:file "packages")
	     (:module "uitoolkit"
		      :depends-on ("packages")
		      :components
		      ((:module "system"
				:serial t
				:components
				((:file "system-constants")
				 (:file "system-classes")
				 (:file "system-conditions") ; not a very good place
				 (:file "system-generics")
				 (:file "system-types")
				 (:file "datastructs")
				 (:file "clib")
				 (:file "comctl32")
				 (:file "comdlg32")
				 (:file "shell32")
				 (:file "gdi32")
				 (:file "kernel32")
				 (:file "user32")
				 (:file "native-object")
				 (:file "system-utils")
				 (:file "metrics")))
		       (:module "graphics"
				:depends-on ("system")
				:components
				((:file "graphics-constants")
				 (:file "graphics-classes")
				 (:file "graphics-generics")
				 (:file "color"
					:depends-on ("graphics-classes"))
				 (:file "palette"
					:depends-on ("graphics-classes"))
				 (:file "image-data"
					:depends-on ("graphics-classes"))
				 (:file "image"
					:depends-on ("graphics-classes" "graphics-generics"))
				 (:file "icon-bundle"
					:depends-on ("graphics-constants" "image"))
				 (:file "cursor"
					:depends-on ("graphics-classes" "image"))
				 (:file "font-data")
				 (:file "font")
				 (:file "graphics-context")
				 (:module "plugins"
					  :components
					  ((:file "graphics-plugin-packages")
					   #-skip-default-plugin        (:module "default"
										 :serial t
										 :components
										 ((:file "file-formats")
										  (:file "default-data-plugin")))
					   #+load-imagemagick-plugin    (:module "imagemagick"
										 :serial t
										 :components
										 ((:file "magick-core-types")
										  (:file "magick-core-api")
										  (:file "magick-data-plugin"
											 :depends-on ("magick-core-types" "magick-core-api"))))))))
		       (:module "widgets"
				:depends-on ("graphics")
				:serial t
				:components
				((:file "widget-constants")
				 (:file "widget-classes")
				 (:file "layout-classes")
				 (:file "thread-context") ; require defun in top-level.lisp
				 (:file "message-generics")
				 (:file "event-generics")
				 (:file "layout-generics")
				 (:file "widget-generics")
				 (:file "display")
				 (:file "event-source")
				 (:file "widget-utils")
				 (:file "timer")
				 (:file "item")
				 (:file "widget")
				 (:file "color-dialog")
				 (:file "file-dialog")
				 (:file "font-dialog")
				 (:file "control") ; require append-layout-item, subclass-wndproc
				 (:file "edit") 
				 (:file "label")
				 (:file "button")
				 (:file "item-manager") 
				 (:file "list-item") ; require lb-select-item lb-deselect-item
				 (:file "list-box")
				 (:file "menu")
				 (:file "menu-item")
				 (:file "defmenu")
				 (:file "progress-bar")
				 (:file "event") ; require set-window-origin
				 (:file "scrolling-helper") ; require obtain-top-child
				 (:file "scrollbar") 
				 (:file "slider")
				 (:file "status-bar")
				 (:file "window") ; require arrang-hwnds
				 (:file "root-window")
				 (:file "top-level")
				 (:file "panel")
				 (:file "dialog")
				 (:file "layout")
				 (:file "border-layout")
				 (:file "heap-layout")
				 (:file "flow-layout")
				 (:file "defwindow")))))))))

(defmethod perform :after ((op load-op) (c (eql (find-system :graphic-forms-uitoolkit))))
  (pushnew :graphic-forms *features*))
