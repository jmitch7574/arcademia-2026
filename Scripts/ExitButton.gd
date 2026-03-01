extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("p1_exit") or Input.is_action_just_pressed("p1_exit"):
		SceneTransitioner.move_to_scene("res://MainMenu.tscn")
