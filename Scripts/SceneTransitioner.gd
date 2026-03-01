extends Node

var tween : Tween
var overlay : ColorRect

func _ready() -> void:
	var canvas_layer = CanvasLayer.new()
	canvas_layer.layer = 1000
	add_child(canvas_layer)

	overlay = ColorRect.new()
	overlay.color = Color(0, 0, 0, 0)
	
	
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE 
	
	canvas_layer.add_child(overlay)

func move_to_scene(path : String):
	if tween:
		if tween.is_running():
			return
	
	tween = create_tween()
	tween.tween_property(overlay, "color", Color(0, 0, 0, 1), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).finished.connect(func():
		get_tree().change_scene_to_file(path)
	)
	tween.tween_property(overlay, "color", Color(0, 0, 0, 0), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
