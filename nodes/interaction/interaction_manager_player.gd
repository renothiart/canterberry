extends InteractionManager # PLAYER

# overwrite with interaction behavior for each interactable object
func interact_echo(key) -> void:
	get_parent().echo(key)
