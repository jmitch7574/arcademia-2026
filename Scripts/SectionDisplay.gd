extends RichTextLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match GameStateManager.current_state:
		GameStateManager.GAMESTATE.BUY_TIME:
			text = "Buy Phase"
		GameStateManager.GAMESTATE.PRE_BATTLE:
			text = "Get Ready..."
		GameStateManager.GAMESTATE.BATTLE:
			text = "FIGHT!"
		GameStateManager.GAMESTATE.BATTLE_END:
			text = "Good Job"
			## TODO: Different text if player loses
