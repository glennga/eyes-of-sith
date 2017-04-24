;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name: Glenn Galvizo; Date: April 16, 2017
;;;; Course: ICS313; Assignment: 6
;;;; File: actions.lisp

;;;; This file holds all of the game actions that exist in the eos game.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun introduction ()
  "Gives an introduction to the game."
  (format t (concat-strings (list
			     "--------------------------------------------------------------------------~%"
			     "Welcome to Eyes of Sith!~%~%"
			     
			     "You are a Sith Lord who has been tasked with killing another Sith in~%"
			     "the temple, Darth Nox, by your master Darth Imperius. This is your hardest~%"
			     "task to date- but also the most rewarding. Finish this, and you will finally~%"
			     "be promoted to Darth. Be warned, facing Nox in your current state is... unwise~%"
			     "Collect the right items to defeat the Dark Lord, or perish trying.~%~%"
			     
			     (format nil "The only commands allowed in this game are: ~%~a~%~%"
				     *allowed-commands*)

			     "To interact with an NPC, first \'select\' them and enter \'talk\'. NPCs must be~%"
			     "referred to without spaces in their names (e.g. Darth Nox = darth-nox).~%~%"
			     "Enjoy the game!~%"
			     "--------------------------------------------------------------------------~%~%"))))

(defun A ()
  "Perform the A action for the appropriate NPC."
  (progn (cond ((eq *selected-npc* '^darth@imperius)
		(if (have '^darth@nox@hand)
		    (progn (format t (concat-strings (list ; win game if have hand
						      "--------------------------------------------------------------------------~%"
						      "You hand your master the severed body part. \'Thank you apprentice. This~%"
						      "is what we do to traitors of the Sith. As promised, you are now a Lord of~%"
						      "the Sith.~%~%Congratulations! You have won!~%"
						      "--------------------------------------------------------------------------~%")))
			   (reload))
		    (format t (concat-strings (list ; do nothing otherwise
					       "--------------------------------------------------------------------------~%"
					       "You do not have his hand. Come back to me with Darth Nox\'s severed~%"
					       "hand.~%"
					       "--------------------------------------------------------------------------~%")))))
	       ((eq *selected-npc* '^darth@nox)
		(if (and (have '^mysterious@amulet)
			 (or (have '^blue@lightsaber)
			     (have '^red@lightsaber)))
		    (progn (format t (concat-strings (list ; get hand if have amulet and lightsaber
						      "--------------------------------------------------------------------------~%"
						      "You charge forward and Darth Nox narrowly avoids your blade. He triest to~%"
						      "shock you but the amulet deflects the lightning back toward the Dark Lord~%"
						      "With Nox weakened, you waste no time and push the saber through his heart~%"
						      "He falls to the ground next to the troopers he killed earlier. You pickup~%"
						      "Darth Nox's Hand.~%"
						      "--------------------------------------------------------------------------~%")))
			   (pickup '^darth@nox@hand) 
			   (kill-npc *selected-npc*))
		    (progn (format t (concat-strings (list ; otherwise, die trying to face him too soon 
						      "--------------------------------------------------------------------------~%"
						      "You charge forward and Darth Nox steps to the side. \"Fool. You don't even~%"
						      "have the right tools to defeat me.\" The Dark Lord hurls his lightsaber~%"
						      "toward your knees and chops off your legs. Your last sight is Nox returning~%"
						      "to his desk and resuming his work as normal. ~%~% Try again!~%"
						      "--------------------------------------------------------------------------~%")))
			   (reload))))
	       ((eq *selected-npc* '^imperial@trooper@1)
		(progn (format t (concat-strings (list ; kill the trooper action
						  "--------------------------------------------------------------------------~%"
						  "Your eyes glow red as your slowly raise your arm upward. \"I'm sorry lord-\"~%"
						  "are the last words of this soldier as his body goes limp and drops to the~%"
						  "ground. You take the Kolto Pack from his body.~%"
						  "--------------------------------------------------------------------------~%")))
		       (pickup '^kolto@pack)
		       (kill-npc *selected-npc*)))
	       ((eq *selected-npc* '^imperial@trooper@2)
		(progn (format t (concat-strings (list ; kill the trooper action
						  "--------------------------------------------------------------------------~%"
						  "You extend both of your arms forward as blinding arcs of energy shoot out of~%"
						  "your fingertips. The soldier now lies on the ground, with small arcs of~%"
						  "lightning radiating from his body.~%"
						  "--------------------------------------------------------------------------~%")))
		       (pickup '^blaster)
		       (kill-npc *selected-npc*)))
	       ((eq *selected-npc* '^young@acolyte)
		(progn (format t (concat-strings (list ; kill the young acolyte action
						  "--------------------------------------------------------------------------~%"
						  "With no hesitation, you draw your saber and strike down the innocent young~%"
						  "Acolyte. You take the Training Blade from his body.~%"
						  "--------------------------------------------------------------------------~%")))
		       (pickup '^training@blade)
		       (kill-npc *selected-npc*)))
	       ((eq *selected-npc* '^jedi@1)
		(format t (concat-strings (list ; harm the jedi action
					   "--------------------------------------------------------------------------~%"
					   "\'It looks like we\'re winning now.\' The Jedi drops to the floor, still ~%"
					   "alive and gasping for air.~%"
					   "--------------------------------------------------------------------------~%"))))
	       ((eq *selected-npc* '^jedi@2)
		(format t (concat-strings (list ; harm the jedi action
					   "--------------------------------------------------------------------------~%"
					   "\'It looks like we\'re winning now.\' The Jedi drops to the floor, still~%"
					   "alive and gasping for air.~%"
					   "--------------------------------------------------------------------------~%"))))
	       ((eq *selected-npc* '^jedi@3)
		(progn (format t (concat-strings (list ; free the jedi action
						  "--------------------------------------------------------------------------~%"
						  "You unlock the cage and tell her to run. She hands you her lightsaber. She~%"
						  "replies, \'Thank you. May the force be with you.\' and runs off.~%"
						  "--------------------------------------------------------------------------~%")))
		       (pickup '^blue@lightsaber)
		       (kill-npc *selected-npc*)))
	       ((eq *selected-npc* '^jedi@4)
		(progn (format t (concat-strings (list ; kill the jedi action
						  "--------------------------------------------------------------------------~%"
						  "You swell with anger hearing that phrase. You draw your saber and push your~%"
						  "saber through the his knees. \'How about now?!\' you scream. Within minutes,~%"
						  "the Jedi's screams slowly fade away.~%"
						  "--------------------------------------------------------------------------~%")))
		       (kill-npc *selected-npc*)))
	       ((eq *selected-npc* '^apprentice@harken)
		(format t (concat-strings (list ; comply action
					   "--------------------------------------------------------------------------~%"
					   "You hold in your rage as you begrudgingly comply.~%"
					   "--------------------------------------------------------------------------~%"))))
	       ((eq *selected-npc* '^force@ghost)
		(progn (format t (concat-strings (list ; peaceful ghost action
						  "--------------------------------------------------------------------------~%"
						  "You raise your hands in the air and try to reason with the ghost. The entity~%"
						  "then enters your mind consumes your spirit. Your eyes roll to the inside of~%"
						  "your head and your limp body drops to the stone.~%~% Try again!~%"
						  "--------------------------------------------------------------------------~%")))
		       (reload))))
	 '@)) ; ensure that nothing extra is printed

(defun B ()
  "Perform the B action for the appropriate NPC."
  (progn (cond ((eq *selected-npc* '^darth@imperius)
		(format t (concat-strings (list ; do nothing, display goal
					   "--------------------------------------------------------------------------~%"
					   "Then you know what to do. Do not return to me until your task is done.~%"
					   "--------------------------------------------------------------------------~%"))))
	   ((eq *selected-npc* '^darth@nox)
	    (format t (concat-strings (list  ; no confrontation action
				       "--------------------------------------------------------------------------~%"
				       "You apologize and leave your soon-to-be-dead target alone.~%"
				       "--------------------------------------------------------------------------~%"))))
	   ((eq  *selected-npc* '^imperial@trooper@1)
	    (progn (format t (concat-strings (list ; friendly trooper action
					      "--------------------------------------------------------------------------~%"
					      "You request the Kolto Pack from the trooper. He replies, \'Of course my~%"
					      "lord.\' You now have the Kolto Pack.~%"
					      "--------------------------------------------------------------------------~%")))
		   (pickup '^kolto@pack)
		   (remove-npc-action *selected-npc* 'b)
		   (remove-npc-action *selected-npc* 'a)))
	   ((eq *selected-npc* '^imperial@trooper@2)
	    (progn (format t (concat-strings (list ; friendly trooper action
					      "--------------------------------------------------------------------------~%"
					      "You request the blaster from the trooper. He replies, \'Of course my lord.\'~%"
					      "You now have the Blaster.~%"
					      "--------------------------------------------------------------------------~%")))
		   (pickup '^blaster)
		   (remove-npc-action *selected-npc* 'b)
		   (remove-npc-action *selected-npc* 'a)))
	   ((eq *selected-npc* '^young@acolyte)
	    (format t (concat-strings (list ; friendly young acolyte action
				       "--------------------------------------------------------------------------~%"
				       "He turns on his practice droid and shows himself deflecting the blaster fire.~%"
				       "\'Wow that was pretty good! Keep it up!\'"
				       "--------------------------------------------------------------------------~%"))))
	   ((eq *selected-npc* '^jedi@3)
	    (progn (format t (concat-strings (list ; kill jedi action
					      "--------------------------------------------------------------------------~%"
					      "You draw your saber from your hip and turn on your saber. For a brief moment~%"
					      "the only sound you hear is the humming of your blade. You extend your blade~%"
					      "through the cage to pierce her chest. You pick up her Blue Lightsaber.~%"
					      "--------------------------------------------------------------------------~%")))
		   (pickup '^blue@lightsaber)
		   (kill-npc *selected-npc*)))
	   ((eq *selected-npc* '^apprentice@harken)
	    (progn (format t (concat-strings (list ; kill harken action
					      "--------------------------------------------------------------------------~%"
					      "You extend both arms and shock Harken with all of your lightning. This catches~%"
					      "him by surprise and he falls to the ground, trying to catch his breath. He~%"
					      "stands back up, weakened and angry. He charges at you and you quickly draw~%"
					      "your saber through his chest. He falls to the ground, dead. You take the~%"
					      "Red Lightsaber from his body.~%"
					      "--------------------------------------------------------------------------~%")))
		   (pickup '^red@lightsaber)
		   (kill-npc '^apprentice@harken)))
	   ((eq *selected-npc* '^force@ghost)
	    (if (have '^kolto@pack)
		(progn (format t (concat-strings (list ; no kill w/ kolto pack action
						  "--------------------------------------------------------------------------~%"
						  "You draw your blade and swing it in the direction of the ghost... but it goes~%"
						  "right through him. He chokes you and infects you with some sort of poison.~%"
						  "Luckily you have your Kolto Pack! You inject it and crawl towards one of the~%"
						  "lesser tombs. You manage to grab the Mysterious Amulet and escape before the~%"
						  "ghost notices.~%"
						  "--------------------------------------------------------------------------~%")))
		       (push (list '^kolto@pack 'used-items) *object-npcs*)
		       (pickup '^mysterious@amulet)
		       (kill-npc '^force@ghost))
		(progn (format t (concat-strings (list ; killed w/o kolto pack action
						  "--------------------------------------------------------------------------~%"
						  "You draw your blade and swing it in the direction of the ghost... but it goes~%"
						  "right through him. He chokes you and infects you with some sort of poison.~%"
						  "You can crawl around the temple, but help is too far away. Your world fades~%"
						  "to black.~%"
						  "--------------------------------------------------------------------------~%")))
		       (reload)))))
	 '@)) ; ensure that nothing extra is printed


(defun C ()
  "Perform the C action for the appropriate NPC."
  (progn (cond ((or (eq *selected-npc* '^imperial@trooper@1) (eq *selected-npc* '^imperial@trooper@2))
		(format t (concat-strings (list ; non confrontational trooper action
					   "--------------------------------------------------------------------------~%"
					   "You nod your head at the trooper.~%"
					   "--------------------------------------------------------------------------~%"))))
	       ((eq  *selected-npc* '^young@acolyte)
		(progn (format t (concat-strings (list ; kill young acolyte action
						  "--------------------------------------------------------------------------~%"
						  "You shock the young kid and listen to his squeals. He falls to the ground.~%"
						  "You take his Training Blade.~%"
						  "--------------------------------------------------------------------------~%")))
		       (pickup '^training@blade)
		       (kill-npc '^young@acolyte)))
	       ((eq *selected-npc* '^apprentice@harken)
		(cond ((have '^blue@lightsaber)
		       (progn (format t (concat-strings (list ; kill w/ jedi lightsaber action
							 "--------------------------------------------------------------------------~%"
							 "You extend both arms to shock Harken and the acolytes with all of your~%"
							 "might. You weaken Harken, but the acolytes manage to snatch your personal~%"
							 "saber away. You then pull out the lightsaber obtained from the Jedi and~%"
							 "strike them all down, spraying blood all over the walls.~%"
							 "--------------------------------------------------------------------------~%")))
			      (push (list 'your-saber 'used-items) *object-npcs*)
			      (kill-npc '^apprentice@harken)
			      (kill-npc '^acolyte@1)
			      (kill-npc '^acolyte@2)))
		      ((have '^blaster)
		       (progn (format t (concat-strings (list ; kill w/ jedi blaster action
							 "--------------------------------------------------------------------------~%"
							 "You extend both arms to shock Harken and the acolytes with all of your~%"
							 "might. You weaken Harken, but the acolytes manage to snatch your personal~%"
							 "saber away. You then pull out the blaster from the Trooper and~%"
							 "shoot them all down, spraying blood all over the walls.~%"
							 "--------------------------------------------------------------------------~%")))
			      (push (list 'your-saber 'used-items) *object-npcs*)
			      (kill-npc '^apprentice@harken)
			      (kill-npc '^acolyte@1)
			      (kill-npc '^acolyte@2)))
		      (t (progn (format t (concat-strings (list ; be killed w/o objects actions
							   "--------------------------------------------------------------------------~%"
							   "You extend both arms to shock Harken and the acolytes with all of your~%"
							   "might. You weaken Harken, but the acolytes manage to snatch your personal~%"
							   "saber away. Harken rises backs up and stabs you in the chest. You fall to~%"
							   "the floor and watch as the rest of the temple passes on by.~%"
							   "~%Try again!~%"
							   "--------------------------------------------------------------------------~%")))
				(reload)))))
	       ((eq *selected-npc* '^force@ghost)
		(progn (format t (concat-strings (list ; be killed by shocking action
						  "--------------------------------------------------------------------------~%"
						  "You hurl lightning at the ghost, but it absorbs it and cackles. The ghost~%"
						  "then hurls the lightning back, killing you instantly.~%"
						  "~%Try again!~%"
						  "--------------------------------------------------------------------------~%")))
		       (reload))))
	 '@)) ; ensure that nothing extra is printed




