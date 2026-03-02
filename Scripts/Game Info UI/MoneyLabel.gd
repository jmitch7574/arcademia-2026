extends RichTextLabel

@export var player_stats : PlayerStats

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "[wave amp=10.0 freq=3.0 connected=1][img=64]res://Assets/money.png[/img][color=#ffd24b] " + str(player_stats.money) + "[/color]"
