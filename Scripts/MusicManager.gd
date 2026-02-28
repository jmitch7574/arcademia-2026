extends Node2D

@onready var bassline: AudioStreamPlayer2D = $Bassline
@onready var melody: AudioStreamPlayer2D = $Melody

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	GameEvents.battle_begin.connect(func():
		melody.volume_db = 0
	)
	GameEvents.battle_end.connect(func(_winner : PlayerStats.PLAYER):
		melody.volume_db = -50
	)
