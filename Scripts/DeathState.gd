extends State

@export var sprite_renderer : Sprite2D
@export var unit : Unit

const GRAVE = preload("uid://x17adh6lqoyx")
var regular_sprite : Texture


func _ready():
	regular_sprite = sprite_renderer.texture

func state_entry_condition() -> bool:
	return unit.health <= 0
	
func _enter_state() -> void:
	sprite_renderer.texture = GRAVE

func _exit_state() -> void:
	sprite_renderer.texture = regular_sprite
