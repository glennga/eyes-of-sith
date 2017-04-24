;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name: Glenn Galvizo; Date: April 16, 2017
;;;; Course: ICS313; Assignment: 6
;;;; File: deflopn.lisp

;;;; This file holds all of the locations, objects, paths, and NPCS
;;;; that exist in the eos.lisp game.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; load all locations...
(new-location ^valley@of@the@dark@lords
	      "The air is still but it is neither hot or cold. You look up and see sand for miles. The faint droning of nearby speeders and starships are all you can hear.")
(new-location ^tomb@of@darth@bane
	      "Torches surrond the room. The hair on your arm stands raises as you feel the raw power emanating from the tomb. You hear faint whispers in the background but you see no one.")
(new-location ^sith@temple
	      "The room is chilling despite there being a large amount of people around. This place is bustling with individuals all from all over: Imperial officers, soldiers, bounty hunters, and of course, Sith.")
(new-location ^execution@chambers
	      "You see rows of Jedi trapped in cages. For every Jedi scream heard, the interrogators scream louder in rage and excitement.")
(new-location ^dark@councils@chambers
	      "You see an empty row of decorated thrones. All of the lords are currently in a meeting.")
(new-location ^chamber@of@darth@nox
	      "The room is poorly lit, but you see every detail. One side of the room is painted with Republic blood while the other is sparkling clean. You glance at the dead Repubic troopers only to see the look of terror permanently painted on their lifeless faces.")
(new-location ^meeting@room
	      "You have interrupted the Dark Council meeting! The closest Dark Lord, Darth Thanton force chokes you as your world fades to black.")
(new-location ^mysterious@room
	      "You have fallen into a pit of poison! You scream in agony and cry for help but no one can hear you. Your last sights are of the bones in your hand- with your skin disintegrating around it.")

;;; load all edges
(new-path ^valley@of@the@dark@lords ^tomb@of@darth@bane walkway north south)
(new-path ^valley@of@the@dark@lords ^sith@temple door east west)
(new-path ^tomb@of@darth@bane ^mysterious@room door left)
(new-path ^sith@temple ^dark@councils@chambers stairway upstairs downstairs)
(new-path ^sith@temple ^execution@chambers door left right)
(new-path ^sith@temple ^chamber@of@darth@nox door right left)
(new-path ^dark@councils@chambers ^meeting@room door right left)

;;; load all user-friendly NPC name
(new-npc-name ^imperial@trooper@1 imperial-trooper-1)
(new-npc-name ^imperial@trooper@2 imperial-trooper-2)
(new-npc-name ^imperial@trooper@3 imperial-trooper-3)
(new-npc-name ^young@acolyte young-acolyte)
(new-npc-name ^force@ghost force-ghost)
(new-npc-name ^acolyte@1 acolyte-1)
(new-npc-name ^acolyte@2 acolyte-2)
(new-npc-name ^apprentice@harken apprentice-harken)
(new-npc-name ^dark@temple@guard@1 dark-temple-guard-1)
(new-npc-name ^dark@temple@guard@2 dark-temple-guard-2)
(new-npc-name ^darth@nox darth-nox)
(new-npc-name ^jedi@1 jedi-1)
(new-npc-name ^jedi@2 jedi-2)
(new-npc-name ^jedi@3 jedi-3)
(new-npc-name ^jedi@4 jedi-4)

;;; load all NPCs
(new-npc ^imperial@trooper@1 
	 "Good afternoon my lord.")
(new-npc ^imperial@trooper@2
	 "Good afternoon my lord.")
(new-npc ^young@acolyte
	 "Hi mister! Can you look over my fighting form?")
(new-npc ^force@ghost
	 "You have upset Darth Bane! You must die!")
(new-npc ^acolyte@1
	 "Sorry my lord. I am currently talking with lord Harken")
(new-npc ^acolyte@2
	 "Sorry my lord. I am currently talking with lord Harken.")
(new-npc ^apprentice@harken
	 "What do you want? Begone.")
(new-npc ^dark@temple@guard@1
	 "Glory to the Sith Empire my lord.")
(new-npc ^dark@temple@guard@2
	 "Glory to the Sith Empire my lord.")
(new-npc ^darth@nox
	 "What do you want? Can you not see I am busy?")
(new-npc ^jedi@1
	 "The force will guide me. You will never win.")
(new-npc ^jedi@2
	 "Kill me if you must. The Jedi have already won.")
(new-npc ^jedi@3
	 "Stronger Sith than you have tried and failed to break me.")
(new-npc ^jedi@4
	 "You will never get anything out of me.")

;;; load all NPC actions
(new-npc-action ^darth@nox b
		"Sorry my lord. I did not mean to interefere.")
(new-npc-action ^darth@nox a
		"I have been sent to kill you. Prepare to die.")
(new-npc-action ^imperial@trooper@1 c
		"Good afternoon.")
(new-npc-action ^imperial@trooper@1 b
		"I need your Kolto Pack.")
(new-npc-action ^imperial@trooper@1 a
		"It is not a good afternoon. *force choke*.")
(new-npc-action ^imperial@trooper@2 c
		"Good afternnon.")
(new-npc-action ^imperial@trooper@2 b
		"Give me your blaster.")
(new-npc-action ^imperial@trooper@2 a
		"Quiet. *shock with lightning*.")
(new-npc-action ^young@acolyte c
		"Show some respect you scum. It is lord. *shock*.")
(new-npc-action ^young@acolyte b
	        "Hi there young fella. Sure thing, show me what you got.")
(new-npc-action ^young@acolyte a
		"Sure thing. *strike down with saber*.")
(new-npc-action ^jedi@1 a
		"Yes we will. *force choke*.")
(new-npc-action ^jedi@2 a
		"As you wish. *force choke*.")
(new-npc-action ^jedi@3 b
		"I am no ordinary sith. *push saber through her
		chest*.")
(new-npc-action ^jedi@3 a
		"I am no ordinary sith. I can get you out of here in exchange for your saber.")
(new-npc-action ^jedi@4 a
		"*pushes saber through knee* How about now?")
(new-npc-action ^apprentice@harken c
		"Back off. I will not be disrespected. *shock Harken with lightning and the Acolytes*.")
(new-npc-action ^apprentice@harken b
		"Back off. I will not be disrespected. *shock only Harken with lightning*.")
(new-npc-action ^apprentice@harken a
		"Of course.")
(new-npc-action ^force@ghost c
		"*you try to shock the ghost*.")
(new-npc-action ^force@ghost b
		"*you draw your saber and try to strike the ghost down*.")
(new-npc-action ^force@ghost a
		"Please. I mean you no harm.")

;;; load all NPC locations
(new-npc-location ^imperial@trooper@1 ^valley@of@the@dark@lords)
(new-npc-location ^imperial@trooper@2 ^valley@of@the@dark@lords)
(new-npc-location ^young@acolyte ^valley@of@the@dark@lords)
(new-npc-location ^force@ghost ^tomb@of@darth@bane)
(new-npc-location ^acolyte@1 ^sith@temple)
(new-npc-location ^acolyte@2 ^sith@temple)
(new-npc-location ^apprentice@harken ^sith@temple)
(new-npc-location ^dark@temple@guard@1 ^sith@temple)
(new-npc-location ^dark@temple@guard@2 ^sith@temple)
(new-npc-location ^darth@nox ^chamber@of@darth@nox)
(new-npc-location ^jedi@1 ^execution@chambers)
(new-npc-location ^jedi@2 ^execution@chambers)
(new-npc-location ^jedi@3 ^execution@chambers)
(new-npc-location ^jedi@4 ^execution@chambers)

 ;;; load all objects w/ appropriate NPCs
(new-object ^blaster ^imperial@trooper@2)
(new-object ^kolto@pack ^imperial@trooper@1)
(new-object ^training@blade ^young@acolyte)
(new-object ^blue@lightsaber ^jedi@3)
(new-object ^red@lightsaber ^apprentice@harken)
(new-object ^mysterious@amulet ^force@ghost)
