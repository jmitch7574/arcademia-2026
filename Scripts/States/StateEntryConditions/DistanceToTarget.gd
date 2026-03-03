class_name StateConditionAttackRange
extends StateCondition

@export var target_system : TargetSystem
@export var attack_range : float
@export var unit : Unit

func check_condition() -> bool:
	if target_system.get_target():
		return unit.global_position.distance_to(target_system.get_target().global_position) < attack_range
	return false

func on_state_triggered() -> void:
	pass
