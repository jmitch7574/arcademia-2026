extends State

@export var target_system : TargetSystem

@export var spawn_scene : PackedScene
	
func _enter_state() -> void:
	if target_system.get_target():
		var position = target_system.get_target().global_position
		
		var instance = spawn_scene.instantiate()
		instance.global_position = position
		get_tree().current_scene.add_child(instance)
		instance.source_unit = unit
		
	self_end_state()
