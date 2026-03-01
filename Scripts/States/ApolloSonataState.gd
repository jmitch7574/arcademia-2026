extends State

var charges = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

## Function that decides whether or not this state can be transitioned to
func state_entry_condition() -> bool:
	return charges >= 5
	
func _enter_state() -> void:
	charges = 0
	
	for node in get_tree().get_nodes_in_group("Units"):
		var target_node := node as Unit
		if target_node and target_node.player_owner == unit.player_owner:
			target_node.heal(10, unit)
	
	self_end_state()

func _exit_state() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _state_update(delta: float) -> void:
	pass


func _on_attack_state_attacked() -> void:
	charges += 1
