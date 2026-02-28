extends State

var sprite_renderer : Sprite2D

const GRAVE = preload("uid://x17adh6lqoyx")
var regular_sprite : Texture


func _ready():
	get_sprite_renderer()
	regular_sprite = sprite_renderer.texture

func state_entry_condition() -> bool:
	return unit.health <= 0
	
func _enter_state() -> void:
	sprite_renderer.texture = GRAVE

func _exit_state() -> void:
	sprite_renderer.texture = regular_sprite

func get_sprite_renderer() -> void:
	var parent = get_parent()
	while parent:
		for child in parent.get_children():
			if child is Sprite2D:
				sprite_renderer = child
				return
		
		parent = parent.get_parent()
