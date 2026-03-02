extends RichTextLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameStateManager.current_timer:
		var seconds = GameStateManager.current_timer.time_left
		
		text = ""
		text += "[color=#b62525]" if seconds < 5 else ""
		text += str(int(GameStateManager.current_timer.time_left))
