extends RichTextLabel

@export var game_manager : GameStateManager
@export var target_player : PlayerStats.PLAYER

func _ready() -> void:
	GameEvents.buy_time_begin.connect(func(): text = "Buy Phase")
	GameEvents.buy_time_end.connect(func(): text = "Get Ready...")
	GameEvents.battle_begin.connect(func(): text = "FIGHT")
	GameEvents.battle_end.connect(func(winner : PlayerStats.PLAYER): 
		if winner == target_player:
			text = "Good Job!"
		else:
			text = "Too Bad..."
	)
