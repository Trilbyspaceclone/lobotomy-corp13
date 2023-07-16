//Containment Kit!
//Works simular to the Safty Kits but for containment units.
//Mode 1: Increases if applicable the qliphoth by 1
//Mode 2: If a meltdown is accouring, will give more time.
//Otherwise completely unuseable!

/obj/item/containment_kit
	name = "Qliphoth Unitily And Containment Kit"
	desc = "Q.U.A.C.K for short, this one time use kit allows a containment unit to meltdown for longer or restore a qliphoth!"
	icon = 'icons/obj/tools.dmi'
	icon_state = "quack"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	usesound = 'sound/items/crowbar.ogg'
	slot_flags = ITEM_SLOT_BELT
	force = 5
	throwforce = 7
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=50)
	drop_sound = 'sound/items/handling/crowbar_drop.ogg'
	pickup_sound =  'sound/items/handling/crowbar_pickup.ogg'

	attack_verb_continuous = list("attacks", "bashes", "batters", "bludgeons", "whacks")
	attack_verb_simple = list("attack", "bash", "batter", "bludgeon", "whack")
	toolspeed = 1
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	var/mode = 1

/obj/item/containment_kit/attack_self(mob/user)
	if(!clerk_check(user))
		to_chat(user,"<span class='warning'>You don't know how to use this.</span>")
		return
	switch(mode)
		if(1)
			mode = 2
			to_chat(user, "<span class='notice'>The kit will now be able to increase a meltdown timer.</span>")
		if(2)
			mode = 1
			to_chat(user, "<span class='notice'>The kit will now restore if possable a Qliphoth Count on a abnormality.</span>")

	return

/obj/item/containment_kit/examine(mob/user)
	. = ..()
	switch(mode)
		if(1)
			. += "Is currently set to restore 1 Qliphoth Counter on a abnormality."
		if(2)
			. += "Is currently set to increase a containment units meltdown timer."

/obj/item/containment_kit/proc/clerk_check(mob/living/carbon/human/H)
	if(istype(H) && (H?.mind?.assigned_role == "Clerk"))
		return TRUE
	return FALSE