extends AttackState

@export var targeting_system : TargetSystem

func _enter_state() -> void:
	var target_unit = targeting_system.get_target()
	target_unit.take_damage(9999, unit)
	attack_launched.emit()
	attack_completed.emit(target_unit)
	
	self_end_state()

func _exit_state() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _state_update(delta: float) -> void:
	pass
