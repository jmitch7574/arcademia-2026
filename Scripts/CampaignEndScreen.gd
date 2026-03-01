extends CanvasLayer

@onready var background: ColorRect = $Background
@onready var game_over: Label = $GameOver
@onready var round_message: Label = $RoundMessage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.player_died.connect(on_game_over)
	
	background.color = Color("#00000000")
	game_over.modulate = Color("#fff0")
	round_message.modulate = Color("#fff0")

func on_game_over(_p : PlayerStats.PLAYER):
	var tween = create_tween()
	
	round_message.text = "You Survived for %s rounds" % [GameStateManager.round]
	
	tween.tween_property(background, "color", Color("#00000092"), 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.set_parallel()
	tween.tween_property(game_over, "modulate", Color("#ffff"), 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(round_message, "modulate", Color("#ffff"), 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
