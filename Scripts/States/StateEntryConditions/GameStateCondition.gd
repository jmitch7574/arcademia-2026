class_name StateConditionGameState
extends StateCondition

@export var target_states : Array[GameStateManager.GAMESTATE]


func check_condition() -> bool:
	return target_states.has(GameStateManager.current_state)
