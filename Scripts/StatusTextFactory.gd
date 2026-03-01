extends Node

const STATUS_LABEL = preload("uid://h4oue6vyv86b")

func _ready() -> void:
	GameEvents.unit_health_changed.connect(on_health_changed)

func on_health_changed(unit : Unit, source : Unit, amount : float, new_health : float):
	var new_label = STATUS_LABEL.instantiate()
	get_tree().current_scene.add_child(new_label)
	
	new_label.text = str(int(abs(amount)))
	
	if amount <= 0:
		new_label.modulate = Color.RED
	else:
		new_label.modulate = Color.WEB_GREEN
		
	new_label.global_position = unit.global_position
