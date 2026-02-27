class_name RerollButton
extends InteractableControl

signal reroll_requested

func _on_press() -> void:
	reroll_requested.emit()
