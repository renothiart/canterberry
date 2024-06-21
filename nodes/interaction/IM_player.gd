extends InteractionManager # PLAYER

# overwrite with interaction behavior for each interactable object
func interact_echo(key: String) -> void:
	get_parent().set_key(key)
