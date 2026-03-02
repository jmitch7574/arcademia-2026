extends Control

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", 5, 5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "rotation_degrees", -5, 10).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "rotation_degrees", 0, 5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	tween.set_loops()
