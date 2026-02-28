class_name Unit
extends Node2D

@export var unit_resource : UnitResource
@export var max_health : float
var health : float

signal health_changed(amount, new_health)

var grid_coords

@export var player_owner : FocusManager.PLAYER

func _ready() -> void:
	health = max_health
	get_tree().get_first_node_in_group("GameManager").buy_time_begin.connect(on_round_end)
	
	if (player_owner == FocusManager.PLAYER.PANDORA):
		return
	
	var taken_grid_coords : Array[Vector2] = []
	for node in get_tree().get_nodes_in_group("Units"):
		if node is Unit:
			if node == self:
				continue
			taken_grid_coords.append(node.grid_coords)
	
	
	for x in range(0, 4):
		for y in range(0, 7):
			var coord = Vector2(x, y) if player_owner == FocusManager.PLAYER.ONE else Vector2(9 - x, y)
			
			if taken_grid_coords.has(coord):
				continue
			grid_coords = coord
			global_position = FocusManager.START_POSITION + (grid_coords * 102)
			return

func take_damage(damage : float) -> void:
	health -= damage
	health_changed.emit(damage, health)

func on_round_end() -> void:
	if player_owner == FocusManager.PLAYER.PANDORA:
		queue_free()

	health = max_health
	global_position = FocusManager.START_POSITION + (grid_coords * 102)
