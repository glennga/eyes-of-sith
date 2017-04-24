;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name: Glenn Galvizo; Date: April 16, 2017
;;;; Course: ICS313; Assignment: 6
;;;; File: actions.lisp

;;;; This file holds all of the game actions that exist in the eos game.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun introduction ()
  "Gives an introduction to the game."
  (format t "----------------------------------------------------------------~% Welcome to Eyes of Sith!~%~% You are a Sith apprentice who has been tasked with killing another Sith in temple, Darth Nox. This is your final and hardest task before being promoted to Lord. Be warned, facing the Dark Lord in your current state is... unwise. Collect the right items or perish trying. ~%~% The only commands allowed in this game are: [~a].~%~% To interact with an NPC, first \'select\' them and enter \'talk\'. NPCs must be referred to without spaces in their names (e.g. Darth Nox = darth-nox).~%~% Enjoy!!~%----------------------------------------------------------------~%" *allowed-commands*))

(defun A ()
  "Perform the A action for the appropriate NPC."
  ;; win game if have amulet and lightsaber
  (progn (cond ((eq *selected-npc* '^darth@nox)
		(if (and (have '^mysterious@amulet)
			 (or (have '^blue@lightsaber)
			     (have '^red@lightsaber)))
		    (format t "You charge forward and Darth Nox narrowly avoids your blade. He tries to shock you but the amulet deflects the lightning back toward the Dark Lord. With Nox weakened, you push the saber through his heart. He falls to the ground next to the troopers he killed earlier. ~%~% Congratulations! You have won the game!")
		    (progn (format t "You charge forward and Darth Nox steps to the side. \"Fool. You don't even have the right tools to defeat me.\" The Dark Lord hurls his lightsaber toward your knees and chops off your legs. Your last sight is Nox returning to his desk and resuming his work as normal. ~%~% Try again!")
			   (reload))))
	       ((eq *selected-npc* '^imperial@trooper@1)
		(progn (format t "Your eyes glow red as your slowly raise your arm upward. \"I'm sorry lord-\" are the last words of this soldier as his body goes limp and drops to the ground. You take the Kolto Pack from his body.")
		       (pickup '^kolto@pack)
		       (kill-npc *selected-npc*)))
	       ((eq *selected-npc* '^imperial@trooper@2)
		(progn (format t "You extend both of your arms forward as blinding arcs of energy shoot out of your fingertips. The soldier now lies on the ground, with small arcs of lightning radiating from his body.")
		       (pickup '^blaster)
		       (kill-npc *selected-npc*)))
	       ((eq *selected-npc* '^young@acolyte)
		(progn (format t "With no hesitation, you draw your saber and strike down the innocent young Acolyte. You take the Training Blade from his body.")
		       (pickup '^training@blade)
		       (kill-npc *selected-npc*)))
	       ((eq *selected-npc* '^jedi@1)
		(format t "\'It looks like we\'re winning now.\' The Jedi drops to the floor, still alive and gasping for air."))
	       ((eq *selected-npc* '^jedi@2)
		(format t "\'It looks like we\'re winning now.\' The Jedi drops to the floor, still alive and gasping for air."))
	       ((eq *selected-npc* '^jedi@3)
		(progn (format t "You unlock the cage and tell her to run. She hands you her lightsaber. She replies, \'Thank you. May the force be with you.\' and runs off.")
		       (pickup '^blue@lightsaber)
		       (kill-npc *selected-npc*)))
	       ((eq *selected-npc* '^jedi@4)
		(progn (format t "You swell with anger hearing that phrase. You draw your saber and push your saber through the his knees. \'How about now?!\' you scream. Within minutes, the Jedi's screams slowly fade away.")
		       (kill-npc *selected-npc*)))
	       ((eq *selected-npc* '^apprentice@harken)
		(format t "You hold in your rage as you begrudgingly comply."))
	       ((eq *selected-npc* '^force@ghost)
		(progn (format t "You raise your hands in the air and try to reason with the ghost. The entity then enters your mind consumes your spirit. Your eyes roll to the inside of your head and your limp body drops to the stone.~%~% Try again!")
		       (reload))))
	 '@)) ; ensure that nothing extra is printed

(defun B ()
  "Perform the B action for the appropriate NPC."
  (progn (cond ((eq *selected-npc* '^darth@nox)
		(format t "You apologize and leave your soon-to-be-dead target alone."))
	       ((eq  *selected-npc* '^imperial@trooper@1)
		(progn (format t "You request the Kolto Pack from the trooper. He replies, \'Of course my lord.\' You now have the Kolto Pack.")
		       (pickup '^kolto@pack)))
	       ((eq *selected-npc* '^imperial@trooper@2)
		(progn (format t "You request the blaster from the trooper. He replies, \'Of course my lord.\' You now have the Blaster.")
		       (pickup '^blaster)))
	       ((eq *selected-npc* '^young@acolyte)
		(format t "He turns on his practice droid and shows himself deflecting the blaster fire. \'Wow that was pretty good! Keep it up!\'"))
	       ((eq *selected-npc* '^jedi@3)
		(progn (format t "You draw your saber from your hip and turn on your saber. For a brief moment, the only sound you hear is the humming of your blade. You extend your blade through the cage to pierce her chest. You pick up her Blue Lightsaber.")
		       (pickup '^blue@lightsaber)
		       (kill-npc *selected-npc*)))
	       ((eq *selected-npc* '^apprentice@harken)
		(progn (format t "You extend both arms and shock Harken with all of your lightning. This catches him by surprise and he falls to the ground, trying to catch his breath. He stands back up, weakened and angry. He charges at you and you quickly draw your saber through his chest. He falls to the ground, dead. You take the Red Lightsaber from his body.")
		       (pickup '^red@lightsaber)
		       (kill-npc '^apprentice@harken)))
	       ((eq *selected-npc* '^force@ghost)
		(if (have '^kolto@pack)
		    (progn (format t "You draw your blade and swing it in the direction of the ghost... but it goes right through him. He chokes you and infects you with some sort of poison. Luckily you have your Kolto Pack! You inject it and escape before the ghost notices.")
			   (push (list '^kolto@pack 'used-items) *object-npcs*))
		    (progn (format t "You draw your blade and swing it in the direction of the ghost... but it goes right through him. He chokes you and infects you with some sort of poison. You can crawl around the temple, but help is too far away. Your world fades to black.")
			   (reload)))))
	 '@)) ; ensure that nothing extra is printed
	       
	       
	 
	  
