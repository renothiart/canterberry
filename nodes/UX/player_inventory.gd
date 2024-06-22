extends CanvasLayer # player inventory

# connect scene nodes
@onready var _slot_0 = $slot_0
@onready var _slot_1 = $slot_1
@onready var _slot_2 = $slot_2
@onready var _slot_3 = $slot_3
@onready var inventory_slots = [_slot_0, _slot_1, _slot_2, _slot_3]

# render the player inventory into the scene
func _ready():
	refresh_inventory()


# call this from level to force an update
func refresh_inventory():
	# wipe the inventory
	inventory_null()
	
	# target the current player
	var player_type = Global.get_animation_name(Global.current_player_type)
	print("Updating player inventory:" + player_type)
	
	if player_type == "SK":
		inventory_knight()
	
	else: if player_type == "RM":
		inventory_messenger()
	
	else: if player_type == "TT":
		inventory_thief()
		
	else:
		print("invalid player type; inventory hardcoded to null")


# knight's inventory
func inventory_knight():
	# render the knight's inventory
	var knight_inventory = Global.knight_inventory
	for slot in inventory_slots:
		if slot < knight_inventory.length:
			set_slot(slot, knight_inventory[slot])


# thief's inventory
func inventory_thief():
	# render treasure if player has it
	var thief_has_treasure = Global.thief_has_treasure
	if thief_has_treasure:
		set_slot(_slot_1, "TREASURE")


# messenger's inventory
func inventory_messenger():
	# render flyer if player has it
	var messenger_has_flyer = Global.messenger_has_flyer
	if messenger_has_flyer:
		set_slot(_slot_1, "FLYER")


# null inventory
func inventory_null():
	for slot in inventory_slots:
		set_slot(slot, "NULL")


# actually set the sprites
func set_slot(slot:int, sprite:String):
	var target_slot = inventory_slots[slot]
	target_slot.set_animation(sprite)
