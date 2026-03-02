extends AudioStreamPlayer2D

const ENEMY_SPAWN = preload("uid://ta1bc7o6eaar")
const HIT_HURT = preload("uid://bhq68yg7x8i5x")
const NEW_UNIT = preload("uid://blwt8qipbdoli")
const UNIT_DIE = preload("uid://dwxh2pvcrxrnt")

func _ready() -> void:
	var unit = get_parent()
	if unit is Unit:
		if unit.player_owner == PlayerStats.PLAYER.PANDORA:
			stream = ENEMY_SPAWN
			play()
		else:
			stream = NEW_UNIT
			play()
		
		GameEvents.unit_health_changed.connect(func(hurt_unit : Unit, source : Unit, amount : float, new_health : float): 
			if amount < 0 and hurt_unit == unit:
				stream = HIT_HURT
				play()
		)
		
		GameEvents.unit_killed.connect(func(victim, killer, gold):
			if victim == get_parent():
				stream = UNIT_DIE
				play()
			
				if get_parent().player_owner == PlayerStats.PLAYER.PANDORA:
					reparent(get_tree().current_scene)
					await get_tree().create_timer(1).timeout
					queue_free()
		)
