extends RichTextLabel

@export var game_manager : GameStateManager
@export var target_player : PlayerStats.PLAYER

func _ready() -> void:
	GameEvents.buy_time_begin.connect(func(): new_text("Buy Phase"))
	GameEvents.buy_time_end.connect(func(): new_text("Get Ready..."))
	GameEvents.battle_begin.connect(func(): new_text("FIGHT"))
	GameEvents.battle_end.connect(func(winner : PlayerStats.PLAYER): 
		if winner == target_player:
			new_text("Good Job!")
		else:
			new_text("Too Bad...")
	)

func new_text(new_text : String):
	text = "[wave amp=10.0 freq=3.0 connected=1]" + new_text
	
