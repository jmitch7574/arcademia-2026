class_name StateConditionTimer
extends StateCondition

@export var time : float
@export var run_on_start : bool

var current_time : float = 0

func _ready() -> void:
	GameEvents.battle_begin.connect(func():	
		if run_on_start:
			current_time = 0
		else:
			current_time = time
	)

func _process(delta: float) -> void:
	current_time -= delta

func check_condition() -> bool:
	return current_time <= 0

func on_state_triggered() -> void:
	current_time = time
