class_name PlayerStats
extends Node

enum PLAYER
{
	ONE,
	TWO,
	PANDORA
}

@export var player : PLAYER

var money : int = 3000 #4
signal money_changed(new_value)

var player_level = 1
signal levelled_up(new_level : int)

@onready var money_sfx: AudioStreamPlayer2D = $MoneySFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.battle_end.connect(try_award_victory_money)
	GameEvents.unit_killed.connect(try_award_kill_money)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update_money(change : float):
	money += change
	money_changed.emit(money)
	
	if change > 0:
		money_sfx.play()

func level_up() -> void:
	player_level += 1
	levelled_up.emit(player_level)

func get_level_up_cost() -> int:
	return int(pow(player_level * 1.4, 1.5)) + 2

func get_unit_count() -> int:
	var player_units = 0
	
	for unit in get_tree().get_nodes_in_group("Units"):
		if unit is Unit:
			if unit.player_owner == player:
				player_units += 1
	
	return player_units

func try_award_victory_money(winner : PlayerStats.PLAYER):
	if winner == player:
		update_money(2)

func try_award_kill_money(victim : Unit, killer : Unit, gold_reward : int):
	if killer.player_owner == player:
		update_money(gold_reward)
