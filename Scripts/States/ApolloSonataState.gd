extends State

func _enter_state() -> void:
	for node in get_tree().get_nodes_in_group("Units"):
		var target_node := node as Unit
		if target_node and target_node.player_owner == unit.player_owner:
			target_node.heal(10, unit)
	
	self_end_state()
