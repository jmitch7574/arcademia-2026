extends Sprite2D

@export var mouse_control : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.buy_time_begin.connect(func(): visible = true)
	GameEvents.buy_time_end.connect(func(): visible = false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position.lerp(mouse_control.global_position, delta * 20)
