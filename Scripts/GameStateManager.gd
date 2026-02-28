class_name GameStateManager
extends Node

enum GAMESTATE
{
	BUY_TIME,
	PRE_BATTLE,
	BATTLE,
	BATTLE_END
}

signal buy_time_begin
signal buy_time_end
signal battle_begin
signal battle_end

@onready var buy_time_timer: Timer = $BuyTimeTimer
@onready var pre_round_timer: Timer = $PreRoundTimer
@onready var round_timer: Timer = $RoundTimer
@onready var battle_end_timer: Timer = $PostRoundTimer

static var current_state : GAMESTATE
static var current_timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_state = GAMESTATE.BUY_TIME
	
	buy_time_timer.start()
	buy_time_begin.emit()
	current_timer = buy_time_timer

func _process(delta: float) -> void:
	pass

func _on_buy_time_timer_timeout() -> void:
	current_state = GAMESTATE.PRE_BATTLE
	
	pre_round_timer.start()
	buy_time_end.emit()
	current_timer = pre_round_timer

func _on_pre_round_timer_timeout() -> void:
	current_state = GAMESTATE.BATTLE
	
	round_timer.start()
	battle_begin.emit()
	current_timer = round_timer

func _on_round_timer_timeout() -> void:
	current_state = GAMESTATE.BATTLE_END
	
	battle_end_timer.start()
	battle_end.emit()
	current_timer = battle_end_timer

func _on_post_round_timer_timeout() -> void:
	current_state = GAMESTATE.BUY_TIME
	
	buy_time_timer.start()
	buy_time_begin.emit()
	current_timer = buy_time_timer
