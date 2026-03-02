extends RichTextLabel

@export var player_stats : PlayerStats

func _process(delta: float) -> void:
	text = "[img=48]res://Assets/heart.png[/img][color=#b62525] " + str(player_stats.lives_left)
