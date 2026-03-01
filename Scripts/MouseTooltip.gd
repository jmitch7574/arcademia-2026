extends RichTextLabel

@export var mouse_control : FocusManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.buy_time_begin.connect(func(): visible = true)
	GameEvents.buy_time_end.connect(func(): visible = false)
	GameEvents.player_died.connect(func(player : PlayerStats.PLAYER): queue_free())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position.lerp(mouse_control.get_parent().global_position, delta * 20)
	
	if mouse_control.picked_up_unit:
		text = "Press B to sell Unit for [img=32]res://Assets/money.png[/img][color=#ffd24b] %s" % [mouse_control.picked_up_unit.unit_resource.unit_cost - 2]
	else:
		text = ""
