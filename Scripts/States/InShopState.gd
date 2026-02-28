class_name InShopState
extends State

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _state_update(delta: float) -> void:
	pass

## Function that decides whether or not this state can be transitioned to
func state_entry_condition() -> bool:
	return GameStateManager.current_state != GameStateManager.GAMESTATE.BATTLE

func _enter_state() -> void:
	pass

func _exit_state() -> void:
	pass
