class_name GameStateManager
extends Node

enum GAMESTATE
{
	BUY_TIME,
	PRE_BATTLE,
	BATTLE,
	BATTLE_END,
	LOSS
}


@onready var buy_time_timer: Timer = $BuyTimeTimer
@onready var pre_round_timer: Timer = $PreRoundTimer
@onready var round_timer: Timer = $RoundTimer
@onready var battle_end_timer: Timer = $PostRoundTimer

static var current_state : GAMESTATE
static var current_timer : Timer

static var round = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	round = 1
	current_state = GAMESTATE.BUY_TIME
	
	buy_time_timer.start()
	GameEvents.buy_time_begin.emit()
	current_timer = buy_time_timer
	
	GameEvents.player_died.connect(on_player_died)

func get_faction_counts() -> Array[int]:
	var player_one_count = 0
	var player_two_count = 0
	var pandora_count    = 0
	
	for unit in get_tree().get_nodes_in_group("Units"):
		if unit is Unit:
			if unit.health > 0:
				match unit.player_owner:
					PlayerStats.PLAYER.ONE:
						player_one_count += 1
					PlayerStats.PLAYER.TWO:
						player_two_count += 1
					PlayerStats.PLAYER.PANDORA:
						pandora_count += 1
	
	return [player_one_count, player_two_count, pandora_count]

func _process(delta: float) -> void:
	if current_state == GAMESTATE.BATTLE:
		var factions = get_faction_counts()
		if factions[0] <= 0 or (factions[1] + factions[2]) <= 0:
			early_exit()

func early_exit() -> void:
	round_timer.stop()
	_on_round_timer_timeout()

func calculate_winner() -> void:
	var factions = get_faction_counts()
	print(factions)
	var winner : PlayerStats.PLAYER
	
	if factions[0] > (factions[1] + factions[2]):
		winner = PlayerStats.PLAYER.ONE
	else:
		if (factions[1] > factions[2]):
			winner = PlayerStats.PLAYER.TWO
		else:
			winner = PlayerStats.PLAYER.PANDORA
	
	GameEvents.battle_end.emit(winner)

func _on_buy_time_timer_timeout() -> void:
	current_state = GAMESTATE.PRE_BATTLE
	
	pre_round_timer.start()
	GameEvents.buy_time_end.emit()
	current_timer = pre_round_timer

func _on_pre_round_timer_timeout() -> void:
	current_state = GAMESTATE.BATTLE
	
	round_timer.start()
	GameEvents.battle_begin.emit()
	current_timer = round_timer

func _on_round_timer_timeout() -> void:
	current_state = GAMESTATE.BATTLE_END
	
	battle_end_timer.start()
	calculate_winner()
	current_timer = battle_end_timer

func _on_post_round_timer_timeout() -> void:
	round += 1
	current_state = GAMESTATE.BUY_TIME
	
	buy_time_timer.start()
	GameEvents.buy_time_begin.emit()
	current_timer = buy_time_timer


func _on_shop_process_player_skip(player: PlayerStats.PLAYER) -> void:
	buy_time_timer.stop()
	current_state = GAMESTATE.PRE_BATTLE
	
	pre_round_timer.start()
	GameEvents.buy_time_end.emit()
	current_timer = pre_round_timer

func on_player_died(player : PlayerStats.PLAYER):
	current_timer.stop()
	round_timer.stop()
	battle_end_timer.stop()
	pre_round_timer.stop()
	buy_time_timer.stop()
	
	await get_tree().create_timer(10).timeout
	
	get_tree().change_scene_to_file("res://MainMenu.tscn")
