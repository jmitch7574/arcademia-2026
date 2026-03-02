class_name SkipButton
extends InteractableControl

signal skip_requested

func _on_press() -> void:
	skip_requested.emit()
