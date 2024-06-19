extends CharacterBody2D

# this script can be attached to any interactable NPC or scene object
# add InteractionManager.tscn as a node, and detach the default script
# attach a new script to the IM called interaction_manager_<OBJECT_NAME>.tscn
# in the new script, define interaction behavior in the interact() method
@onready var _interaction_manager = $InteractionManager
