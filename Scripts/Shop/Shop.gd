extends Control

var default_size : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	default_size = size
	GameEvents.buy_time_begin.connect(zoom_in)
	GameEvents.buy_time_end.connect(zoom_out)

func zoom_out() -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "size", default_size * 1.5, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", Vector2(-405, 34), 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func zoom_in() -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "size", default_size, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", Vector2(50, 34), 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
