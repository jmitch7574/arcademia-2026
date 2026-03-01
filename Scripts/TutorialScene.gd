extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("p1_accept"):
		SceneTransitioner.move_to_scene("res://GameScene.tscn")
