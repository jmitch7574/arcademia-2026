class_name TargetSystem
extends Node2D

var current_target : Node2D = null

func get_target() -> Node2D:
	if current_target == null:
		current_target = get_new_target()
		
	return current_target

func get_new_target():
	pass
