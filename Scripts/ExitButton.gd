extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("p1_exit") or Input.is_action_just_pressed("p1_exit"):
		get_tree().change_scene_to_file("res://MainMenu.tscn")
