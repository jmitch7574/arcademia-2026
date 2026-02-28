extends RichTextLabel

@export var player_stats : PlayerStats

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "[img=64]res://Assets/money.png[/img][color=#ffd24b] " + str(player_stats.money) + "[/color]"
