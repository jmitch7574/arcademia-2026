class_name TargetSystem
extends Node2D

@export var parent : Unit
var current_target : Node2D = null

func _process(delta: float) -> void:
	if (current_target):
		if (current_target.global_position.x < global_position.x):
			parent.global_scale.x = -abs(parent.global_scale.x)
		else:
			parent.global_scale.x = abs(parent.global_scale.x)

func get_target() -> Node2D:
	if current_target == null:
		current_target = get_new_target()
		
	return current_target

func get_new_target():
	pass
