extends RichTextLabel

@export var game_manager : GameStateManager
@export var target_player : FocusManager.PLAYER

func _ready() -> void:
	game_manager.buy_time_begin.connect(func(): text = "Buy Phase")
	game_manager.buy_time_end.connect(func(): text = "Get Ready...")
	game_manager.battle_begin.connect(func(): text = "FIGHT")
	game_manager.battle_end.connect(func(winner : FocusManager.PLAYER): 
		if winner == target_player:
			text = "Good Job!"
		else:
			text = "Too Bad..."
	)
