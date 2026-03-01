extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var move_tween = create_tween()
	move_tween.set_loops()
	
	var original_position = position
	var target_position = position + Vector2(0, -20)
	
	
	move_tween.tween_property(self, ^"position", target_position, 3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	move_tween.tween_property(self, ^"position", original_position, 3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	
	move_tween.custom_step(randf_range(0, 6))
