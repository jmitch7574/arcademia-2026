class_name Unit
extends Node2D

enum EFFECTS
{
	WEBBED
}

@export var unit_resource : UnitResource
@export var max_health : float
var health : float

signal health_changed(amount, new_health)

var grid_coords

var is_loki_clone = false

@export var player_owner : PlayerStats.PLAYER

var audio_player : AudioStreamPlayer2D

var effects : Array[EFFECTS] = []

func _ready() -> void:
	audio_player = AudioStreamPlayer2D.new()
	add_child(audio_player)
	
	health = max_health
	GameEvents.buy_time_begin.connect(on_round_end)
	
	if (player_owner == PlayerStats.PLAYER.PANDORA):
		var valid_coord = false
		
		var coord = Vector2(0, 0)
		
		while not valid_coord:
			valid_coord = true
			coord = Vector2(randi_range(5, 9), randi_range(0, 7))
			for node in get_tree().get_nodes_in_group("Units"):
				if node is Unit:
					if node == self:
						continue
					if node.grid_coords == coord:
						valid_coord = false
			
	
	var taken_grid_coords : Array[Vector2] = []
	for node in get_tree().get_nodes_in_group("Units"):
		if node is Unit:
			if node == self:
				continue
			taken_grid_coords.append(node.grid_coords)
	
	
	for x in range(0, 4):
		for y in range(0, 7):
			var coord = Vector2(x, y) if player_owner == PlayerStats.PLAYER.ONE else Vector2(9 - x, y)
			
			if taken_grid_coords.has(coord):
				continue
			grid_coords = coord
			global_position = FocusManager.START_POSITION + (grid_coords * 102)
			return

func take_damage(damage : float, source : Unit) -> void:
	health -= damage
	health_changed.emit(-damage, health)
	
	if health <= 0:
		GameEvents.unit_killed.emit(self, source, 1)
	
	if player_owner == PlayerStats.PLAYER.PANDORA and health <= 0:
		queue_free()

func on_round_end() -> void:
	if player_owner == PlayerStats.PLAYER.PANDORA or is_loki_clone:
		queue_free()

	health = max_health
	global_position = FocusManager.START_POSITION + (grid_coords * 102)
	effects = []
