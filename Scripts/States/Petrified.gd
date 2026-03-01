extends State

var time_passed : float

var sprite_renderer : Sprite2D

const ROCK_MATERIAL = preload("uid://c1h54rcpaqonv")
const UNIT = preload("uid://dlhhnx45g42ri")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_sprite_renderer()

## Function that decides whether or not this state can be transitioned to
func state_entry_condition() -> bool:
	return false
	
func _enter_state() -> void:
	sprite_renderer.material = ROCK_MATERIAL
	time_passed = 0
	pass

func _exit_state() -> void:
	sprite_renderer.material = UNIT
	pass

func _state_update(delta: float):
	time_passed += delta
	
	if time_passed > 3 or unit.health <= 0 or GameStateManager.current_state != GameStateManager.GAMESTATE.BATTLE:
		self_end_state()

func get_sprite_renderer() -> void:
	var parent = get_parent()
	while parent:
		for child in parent.get_children():
			if child is Sprite2D:
				sprite_renderer = child
				return
		
		parent = parent.get_parent()
