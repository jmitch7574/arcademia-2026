extends AudioStreamPlayer2D

const ROUND_LOST = preload("uid://be86bi2kah6ws")
const VICTORY = preload("uid://bq1cyqrwv5rvn")

func _ready() -> void:
	GameEvents.battle_end.connect(play_theme)

func play_theme(winner : PlayerStats.PLAYER):
	if winner == PlayerStats.PLAYER.PANDORA:
		stream = ROUND_LOST
		play()
	else:
		stream = VICTORY
		play()
