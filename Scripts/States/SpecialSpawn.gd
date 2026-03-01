extends State

@export var target_system : TargetSystem

@export var spawn_scene : PackedScene

@export var required_charges : int

var charges = 0

## Function that decides whether or not this state can be transitioned to
func state_entry_condition() -> bool:
	return charges >= required_charges
	
func _enter_state() -> void:
	charges = 0
	if target_system.get_target():
		var position = target_system.get_target().global_position
		
		var instance = spawn_scene.instantiate()
		instance.global_position = position
		get_tree().current_scene.add_child(instance)
		instance.source_unit = unit
		
	self_end_state()

func _exit_state() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _state_update(delta: float) -> void:
	pass

func _on_attack_state_attacked(unit: Unit) -> void:
	charges += 1
