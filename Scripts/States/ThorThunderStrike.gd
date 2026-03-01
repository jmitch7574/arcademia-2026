extends State

@export var target_system : TargetSystem

const LIGHTNING = preload("uid://bn4s7iijx68dg")

var charges = 0

## Function that decides whether or not this state can be transitioned to
func state_entry_condition() -> bool:
	return charges >= 2
	
func _enter_state() -> void:
	charges = 0
	if target_system.get_target():
		var position = target_system.get_target().global_position
		
		var strike = LIGHTNING.instantiate()
		strike.global_position = position
		get_tree().current_scene.add_child(strike)
		strike.source_unit = unit
		
	self_end_state()

func _exit_state() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _state_update(delta: float) -> void:
	pass

func _on_attack_state_attacked(target : Unit) -> void:
	charges += 1
