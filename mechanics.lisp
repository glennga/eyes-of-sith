;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name: Glenn Galvizo; Date: April 16, 2017
;;;; Course: ICS313; Assignment: 6
;;;; File: mechanics.lisp

;;;; Thie file holds the mechanics for the eos game.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; *NODES* refer to all places a user can exist in at a given time.
;;; Currently formatted such that a node cell holds the location name
;;; first, and then the description following it. Locations are
;;; currently defined in deflopn.lisp.
(defparameter *nodes* nil)

;;; *NOT-VISITED* refers to locations the user has not visited yet.
(defparameter *not-visited* nil)
(defparameter *visited* nil)
  
(defun describe-location (location nodes)
  "Given the location and node list, return description of location."
  (progn (format t "--------------------------------------------------------------------------~%")
	 (format t (cadr (assoc location nodes)))
	 (format t "--------------------------------------------------------------------------~%")))

(defun state-location (loc)
  "State the location given. Avoids verbose output w/ describe-location."
  `(you are now in the ,loc on ^korriban.))

(defmacro new-location (loc desc)
  "Macro to simplify adding locations."
  `(if (assoc ',loc *nodes*) ; check if location already exists
       (format t "Location ~a already exists." ',loc)
       (progn (push (list ',loc ,desc) *nodes*)
	      (push ',loc *not-visited*)))) ; otherwise, add to list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; *EDGES* refer to the pathways a user can traverse to get to one
;;; node from another. Current formatted such that an edge cell holds
;;; the location name first, and a cell of the destination node,
;;; the direction, and the medium (in that order). Edges are currently
;;; defined in deflop.lisp.
(defparameter *edges* nil)

(defun describe-path (edge)
  "Given edge, return description of that edge."
  `(there is a ,(caddr edge) going ,(cadr edge) from here.))

(defun describe-paths (location edges)
  "Given a location, return description of edges around that location."
  (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))

(defmacro new-path (from-loc to-loc medium dir &optional opp-dir)
  "Macro to simplify adding new paths to game. Used in deflopn.lisp"
  `(cond ((not (assoc ',from-loc *nodes*)) ; check if from-loc exists
	  (format t "Location ~a does not exist." ',from-loc))
	 ((not (assoc ',to-loc *nodes*)) ; check if to-loc exists
	  (format t "Location ~a does not exist." ',to-loc))
	 ((not (member ',dir ; make sure that dir doesn't already exist in from-loc
		       (mapcar #'cadr (cdr (assoc ',from-loc *edges*))) :test 'equal))
	  
	  (if (not (eq ',opp-dir nil)) ; if opp-dir defined (user wants 2-way path)
	      (if (not (member ',opp-dir ; check that opp-dir doesn't already exist
			       (mapcar #'cadr (cdr (assoc ',to-loc *edges*))) :test 'equal))
		  ;; push a NEW edge set to *edges*. old one stays on bottom of stack.
		  ;; works beacuse only the top of the stack is taken.
		  (push (append '(,to-loc) '((,from-loc ,opp-dir ,medium))
				(cdr (assoc ',to-loc *edges*)))
			*edges*)
		  ;; otherwise, opp-dir already exists. return error
		  (format t "Direction ~a already exists in ~a." ',opp-dir ',to-loc)))
	  
	  ;; push new edge from from-loc to to-loc (default, 1-way path)
	  (push (append '(,from-loc) '((,to-loc ,dir ,medium))
			(cdr (assoc ',from-loc *edges*)))
		*edges*))
	 (t (format t "Direction ~a already exists in ~a." ',dir ',from-loc))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; *NPCS* refer to non-playing characters that the user can interact
;;; with. Currently formatted such that an npc cell holds the npc name
;;; first, and dialogue (in that order). Npcs are currently defined in
;;; deflopn.lisp.
(defparameter *npcs* nil)
(defparameter *killed-npcs* nil)

;;; *NPC-LOCATIONS* refer to the location of the non-playing characters
(defparameter *npc-locations* nil)

;;; *NPC-ACTIONS* refer to actions a player can do with the NPCs
(defparameter *npc-actions* nil)
(defparameter *killed-npc-actions* nil)

;;; *NPC-NAMES* refer to the names a user references the NPC as
(defparameter *npc-names* nil)

(defun npcs-at (loc npcs npc-loc)
  "Return the NPCs at the given location."
  (labels ((is-at (npc)
	     (eq (cadr (assoc (car npc) npc-loc)) loc)))
    (remove-if-not #'is-at npcs)))

(defun describe-npcs (loc npcs npc-loc)
  "Given location, return description of NPCs at that location."
  (labels ((describe-npc (npc)
	     `(,(car npc) is nearby.)))
     (apply #'append (mapcar #'describe-npc (npcs-at loc npcs npc-loc)))))

(defun kill-npc (npc)
  "Remove the given NPC from the NPC lists."
  (labels ((del-npc (npc-entry)
	     (if (eq (car npc-entry) npc)
		 (push (delete npc-entry *npcs*) *killed-npcs*)))
	   (del-npc-action (npc-act)
	     (if (eq (car npc-act) npc)
		 (push (delete npc-act *npc-actions*)
		       *killed-npc-actions*))))
    (progn (mapcar #'del-npc *npcs*)
	   (mapcar #'del-npc-action *npc-actions*)
	   '@)))

(defun npc-names-at (loc npc-names npcs npc-loc)
  "Return the NPC names at the given location."
  (labels ((find-npc-name (npc)
	     (cdr (assoc (car npc) npc-names))))
    (apply #'append (mapcar #'find-npc-name (npcs-at loc npcs npc-loc)))))

(defun npc-talk-to (npc)
  "Given NPC, print the appropriate dialogue."
  (format t "~a~%" (cadr (assoc npc *npcs*))))

(defun get-actions (npc npc-act)
  "Get the actions associated with the given NPC."
  (labels ((is-npc (npc-entry)
	     (eq (car npc-entry) npc)))
    (remove-if-not #'is-npc npc-act)))

(defmacro new-npc-name (npc npc-name)
  "Macro to simplify adding new objects."
  `(if (assoc ',npc *npc-names*)
       (format t "NPC ~a already has a name." ',npc)
       (push (list ',npc ',npc-name) *npc-names*)))

(defmacro new-npc (npc dia)
  "Macro to simplify adding new NPCS."
  `(if (assoc ',npc *npcs*) ; check if NPC already exists
       (format t "NPC ~a already exists." ',npc)
       (push (list ',npc ',dia) *npcs*))) ; otherwise, add to list 

(defmacro new-npc-location (npc npc-loc)
  "Macro to simplify adding new NPC locations."
  `(cond ((not (assoc ',npc *npcs*)) ; check if NPC already exists
	  (format t "NPC ~a does not exist." ',npc))
	 ((not (assoc ',npc-loc *nodes*)) ; check if location exists
	  (format t "Location ~a does not exist." ',npc-loc))
	 (t ; otherwise, add to NPC list
	    (push (list ',npc ',npc-loc) *npc-locations*))))

(defmacro new-npc-action (npc actid act)
  "Macro to simplify adding new NPC actions."
  `(if (not (assoc ',npc *npcs*)) ; check if NPC already exists
       (format t "NPC ~a does not exist." ',npc)
       (push (list ',npc ',actid ',act) *npc-actions*)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; *OBJECTS* refer to the items a user can interact with in the game.
;;; Objects are currently defined in deflop.lisp.
(defparameter *objects* '(your-saber))

;;; *OBJECT-NPC* refer to the NPCs locations associated with each
;;; item above. Currently formatted such that the a cell holds the
;;; object name followed by where that object is located.
;;; Object NPCs are currently defined in deflopn.lisp.
(defparameter *object-npcs* nil)

(defun objects-on (npc objs obj-npc)
  "Given NPC and object sets, return items on current NPC."
  (labels ((is-at (obj)
	     (eq (cadr (assoc obj obj-npc)) npc)))
    (remove-if-not #'is-at objs)))

(defmacro new-object (obj obj-npc)
  "Macro to simplify adding new objects."
  `(cond ((member ',obj *objects* :test 'equal) ; check if object already exists
	  (format t "Object ~a already exists." ',obj))
	 ((not (assoc ',obj-npc *npcs*)) ; check if NPC exists
	  (format t "NPC ~a does not exist." ',obj-npc))
	 (t (push ',obj *objects*) ; otherwise, add to objects and NPC list
	    (push (list ',obj ',obj-npc) *object-npcs*))))

;;; *LOCATION* refers to the current location the user resides at.
(defparameter *location* '^valley@of@the@dark@lords)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun look ()
  "Return description of NPCs, edges at the current location."
  (prog1 (append (describe-location *location* *nodes*)
		 (state-location *location*)
		 (describe-paths *location* *edges*)
		 (describe-npcs *location* *npcs* *npc-locations*))
	 (if (member *location* *not-visited*) ; remove from not-visited list
	     (push (delete *location* *not-visited*) *visited*))))

(defun look-simple ()
  "Return description of NPCS w/o verbose describe-location function."
  (append (state-location *location*)
	  (describe-paths *location* *edges*)
	  (describe-npcs *location* *npcs* *npc-locations*)))

(defun inventory ()
  "Describe current items in inventory."
  (cons 'items- (objects-on 'user *objects* *object-npcs*)))

(defun pickup (object)
  "Given object, put object in inventory."
  (cond ((member object (objects-on *selected-npc* *objects* *object-npcs*))
	 ;; add object to user in *OBJECT-NPCS*
         (push (list object 'user) *object-npcs*)
         `(you are now carrying the ,object))
	(t '(you cannot get that.)))) ; if object is not found on NPC

(defun have (object)
  "Return NIL if given object is not in inventory, or the inventory if T."
  (member object (cdr (inventory))))

(defun walk (dir)
  "Given direction, go to node associated with edge (change *location*)."
  (labels ((correct-way (edge)
	     (eq (cadr edge) dir)))
    (let ((next (find-if #'correct-way (cdr (assoc *location* *edges*)))))
      (if next 
          (progn (setf *location* (car next)) ; modify location if exists
		 (cond ((member (car next) *not-visited*)
			(look))
		       ;; if one of the traps, reload game
		       ((or (eq next '^mysterious@room) (eq next '^meeting@room))
			(reload))
		       (t (look-simple))))
	  '(you cannot go that way.))))) ; if edge does not exist
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun help ()
  "Return allowed commands."
  (progn (format t "The following commands are accepted =~%~a"
		 *allowed-commands*)
	 '@)) ; print nothing from print

(defun reload ()
  "Reset the game to the beginning state."
  (progn (format t "Your game has been reset.~%")
         (setf *location* '^valley@of@the@dark@lords)
	 (setf *selected-npc* '^imperial@trooper@1)
	 (setf *nodes* nil) (setf *not-visited* nil) (setf *visited* nil)
	 (setf *edges* nil)
	 (setf *npcs* nil) (setf *killed-npcs* nil) (setf *npc-locations* nil)
	 (setf *npc-actions* nil) (setf *npc-names* nil)
	 (setf *objects* nil) (setf *object-npcs* nil)
	 (load (merge-pathnames "deflopn.lisp" *load-truename*))
	 '@)) ; explicitly tell print to not print anything here
  
(defun game-read ()
  "Read user commands and format it to be evaluated by game-eval"
  (let ((cmd (read-from-string (concatenate 'string "(" (read-line) ")"))))
    (flet ((quote-it (x)
	     (list 'quote x)))
      (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))

;;; *ALLOWED-COMMANDS* refer to the only commands accepted by game-eval
(defparameter *allowed-commands* '(look walk inventory help quit reload select talk a b c))

(defun game-eval (sexp)
  "Only evaluate commands in *ALLOWED-COMMANDS*, otherwise give error"
  (if (member (car sexp) *allowed-commands*)
      (if (or (equal (car sexp) '?) (equal (car sexp) 'h))
	  (help) ; if sexp is ? or h, use help
	  (eval sexp)) ; otherwise, use normal command
      (append '(i do not know that command. i only know the following
		commands = [)
	      *allowed-commands*
	      '(].))))

(defun tweak-text (lst caps lit)
  "Remove symbols to produce text that is more human readable."
  (when lst ; exit when empty
    ;; recursively loop through list, handle one item at a time
    (let ((item (car lst)) 
	  (rest (cdr lst)))
      ;; if item is space, then keep and loop again
      (cond ((eql item #\space) (cons item (tweak-text rest caps lit)))
	    ;; if item is punctuation, keep and loop with caps next (end of sentence)
	    ((member item '(#\! #\? #\.)) (cons item (tweak-text rest t lit)))
	    ;; if quote, do not keep and loop again w/ no lit
	    ((eql item #\") (tweak-text rest caps (not lit)))
	    ;; if @ sign, replace with space and capitalize next
	    ((eql item #\@) (cons #\space (tweak-text rest t lit)))
	    ;; if ^ sign, remove and capitalize next
	    ((eql item #\^) (tweak-text rest t lit))
	    ;; if lit, keep item and make next item not lit
	    (lit (cons item (tweak-text rest nil lit)))
	    ;; if caps, then keep w/ uppercase and loop w/o uppercase next
	    (caps (cons (char-upcase item) (tweak-text rest nil lit)))
	    ;; otherwise, keep with downcase and loop w/o caps or lit
	    (t (cons (char-downcase item) (tweak-text rest nil nil)))))))

(defun game-print (lst)
  "Print the results in a user friendly format. Uses tweak-text to help."
  (princ (coerce (tweak-text
		  (coerce (string-trim "() " (prin1-to-string lst)) ; remove ()
			  'list)
		  t nil)
		 'string))
  (fresh-line))

(defun game-repl ()
  "REPL for our game, using specifc game read, print, eval functions."
  (let ((cmd (game-read))) ; read in the command
    (unless (eq (car cmd) 'quit) ; only quit when user enters 'cmd'
      (game-print (game-eval cmd)) ; evaluate the command
      (game-repl)))) ; loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; *SELECTED-NPC* refers to current NPC the user is interacting with
(defparameter *selected-npc* '^imperial@trooper@1)

(defun select (npc-name)
  "Select an NPC to perform actions with."
  (labels ((is-npc-name (npc)
	     (eq npc-name (car (cdr npc)))))
    (list (setf *selected-npc* (car (car (remove-if-not #'is-npc-name
							*npc-names*))))
	  'is 'now 'the 'selected '^N^P^C.)))

(defun talk ()
  "Display dialogue for current NPC name."
  (labels ((print-action (item)
	     (format t "-~a ~a~%" (cadr item) (caddr item))))
    (progn (npc-talk-to *selected-npc*)
	   (format t "--------------------------------------------------------------------------~%")
	   (mapcar #'print-action (get-actions *selected-npc* *npc-actions*))
	   (format t "--------------------------------------------------------------------------~%")
    '@)))

(defun concat-strings (list)
  "Concatenate strings together from a list."
  (apply #'concatenate 'string list))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

