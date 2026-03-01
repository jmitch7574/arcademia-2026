class_name PlayerStats
extends Node

enum PLAYER
{
	ONE,
	TWO,
	PANDORA
}

@export var player : PLAYER

var money : int = 5

var player_level = 1

var lives_left = 3

@onready var money_sfx: AudioStreamPlayer2D = $MoneySFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.battle_end.connect(try_award_victory_money)
	GameEvents.unit_killed.connect(try_award_kill_money)
	GameEvents.buy_time_begin.connect(apply_interest)
	GameEvents.unit_sold.connect(func(amount: int): update_money(amount, "Sold Unit"))

func update_money(change : float, source : String = ""):
	if change == 0:
		return
	money += change
	GameEvents.money_changed.emit(player, change, money, ("-" if change < 0 else "+") + "%s   %s" % [str(int(abs(change))), source])
	
	if change > 0:
		money_sfx.play()

func apply_interest():
	update_money(floor(money / 5), "Interest")

func level_up() -> void:
	player_level += 1
	GameEvents.levelled_up.emit(player_level)

func get_level_up_cost() -> int:
	return int(pow(player_level * 1.5, 2)) + 4

func get_unit_count() -> int:
	var player_units = 0
	
	for unit in get_tree().get_nodes_in_group("Units"):
		if unit is Unit:
			if unit.player_owner == player:
				player_units += 1
	
	return player_units

func try_award_victory_money(winner : PlayerStats.PLAYER):
	await get_tree().create_timer(1).timeout
	
	if winner == player:
		update_money(4, "Round Win")
	else:
		update_money(2, "Round Loss")
		lives_left -= 1
		if lives_left <= 0:
			GameEvents.player_died.emit(player)

func try_award_kill_money(victim : Unit, killer : Unit, gold_reward : int):
	if killer.player_owner == player and randf() < 0.2:
		update_money(gold_reward, "killed enemy")
