extends Node

## States available in this state machine, array order determines priority
@export var states : Array[State]

var current_state : State

const global_states : Dictionary[Resource, bool] = {
	preload("uid://bgm0othjow4am") : true,
	preload("uid://cukpese4y8oec") : true,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.unit_killed.connect(interrupt_state_on_death)

	states = states.filter(func(element): return element!=null)

	if not get_parent().is_loki_clone:
		load_global_states()
	for state in states:
		state.state_concluded.connect(on_state_self_ended)
		state.unit = get_parent()
	
	swap_state(get_next_state())

func load_global_states() -> void:
	for state in global_states:
		var new_state = state.new()
		add_child(new_state)
		states.push_front(new_state)
		new_state.name = state.resource_name
		new_state.interruptible = global_states[state] 

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

func interrupt_state_on_death(death : Unit):
	if death == get_parent():
		swap_state(get_next_state())
