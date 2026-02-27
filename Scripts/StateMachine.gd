extends Node

## States available in this state machine, array order determines priority
@export var states : Array[State]

var current_state : State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for state in states:
		state.state_concluded.connect(on_state_self_ended)
	
	swap_state(get_next_state())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_state._state_update(delta)
	
	if current_state.interruptible:
		swap_state(get_next_state())

func swap_state(newState : State):
	if newState == current_state:
		return
	
	if current_state:
		current_state._exit_state()
	current_state = newState
	newState._enter_state()

func on_state_self_ended() -> void:
	swap_state(get_next_state())

func get_next_state() -> State:
	for state in states:
		if state.state_entry_condition():
			return state

	return null
