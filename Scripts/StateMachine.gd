extends Node

## States available in this state machine, array order determines priority
@export var states : Array[State]

var current_state : State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	swap_state(states[0])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_state._state_update(delta)

func swap_state(newState : State):
	if current_state:
		current_state._exit_state()
	current_state = newState
	newState._enter_state()
