extends Node

## States available in this state machine, array order determines priority
@export var states : Array[State]

var current_state : State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.unit_killed.connect(interrupt_state_on_death)

	load_global_states()
	states = states.filter(func(element): return element!=null)
	
	for state in states:
		state.state_concluded.connect(on_state_self_ended)
		state.unit = get_parent()
	
	swap_state(get_next_state())

func load_global_states() -> void:
	
	## Shop State
	var shop_state = InShopState.new()
	add_child(shop_state)
	
	var shop_condition = StateConditionGameState.new()
	shop_condition.target_states = [GameStateManager.GAMESTATE.BUY_TIME, GameStateManager.GAMESTATE.PRE_BATTLE] as Array[GameStateManager.GAMESTATE]
	shop_state.add_child(shop_condition)
	shop_state.entry_condition = shop_condition
	shop_state.interruptible = true
	
	## Death State
	var death_state = DeathState.new()
	add_child(death_state)
	
	var death_condition = StateConditionHealth.new()
	death_condition.comparison = StateConditionHealth.COMPARISON.DEAD
	death_condition.unit = get_parent()
	
	death_state.add_child(death_condition)
	death_state.entry_condition = death_condition
	death_state.interruptible = true

	## Petrified
	var petrified_state = PetrifiedState.new()
	add_child(petrified_state)
	
	## Add to States
	states = ([shop_state, death_state, petrified_state] as Array[State] + states) as Array[State]

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


func swap_state_by_name(newState : String):
	if newState == current_state.name:
		return
	
	var state_node = get_node(newState)
	
	if current_state and state_node:
		current_state._exit_state()
	
		current_state = state_node
		state_node._enter_state()

func on_state_self_ended() -> void:
	swap_state(get_next_state())

func get_next_state() -> State:
	for state : State in states:
		if state.entry_condition:
			if state.entry_condition.check_condition():
				state.entry_condition.on_state_triggered()
				return state
		

	return null

func interrupt_state_on_death(victim : Unit, killer : Unit, gold_reward : int):
	if victim == get_parent():
		swap_state(get_next_state())
