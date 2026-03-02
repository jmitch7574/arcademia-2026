extends Control

const STATUS_LABEL = preload("uid://h4oue6vyv86b")

var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.money_changed.connect(func(player : PlayerStats.PLAYER, amount: int, new_value : int, cause : String):
		var instance = STATUS_LABEL.instantiate()
		add_child(instance)
		instance.text = cause
		instance.modulate = Color.GOLDENROD if amount >= 0 else Color.RED
		instance.global_position = global_position + Vector2(100, -100)
		
		
		modulate = Color.RED if amount < 0 else Color.GOLDENROD
		if tween: tween.kill()
		tween = create_tween()
		tween.tween_property(self, "modulate", Color.WHITE, 2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	)
