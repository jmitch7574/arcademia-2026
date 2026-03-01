extends RichTextLabel

func _process(delta: float) -> void:
	text = "[wave amp=10.0 freq=3.0 connected=1]" + str(GameStateManager.round) + ""
