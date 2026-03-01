extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	
	var color = modulate
	color.a = 0
	
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(self, "position", global_position + Vector2(0, -100), 1)
	tween.tween_property(self, "modulate", color, 1).finished.connect(func():
		queue_free()
	)
