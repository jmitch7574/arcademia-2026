extends RichTextLabel

@export var player_stats : PlayerStats

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "[wave amp=10.0 freq=3.0 connected=1]%s / %s" % [player_stats.get_unit_count(), player_stats.player_level]
