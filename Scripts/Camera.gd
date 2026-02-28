extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.buy_time_begin.connect(zoom_in)
	GameEvents.buy_time_end.connect(zoom_out)

func zoom_out() -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", Vector2(0, -150), 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func zoom_in() -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", Vector2(0, 0), 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
