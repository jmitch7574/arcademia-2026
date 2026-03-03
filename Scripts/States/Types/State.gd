class_name State
extends Node

@export var interruptible : bool
var entry_conditions : Array[StateCondition]
var unit : Unit

signal state_concluded

func get_conditions() -> void:
	entry_conditions = []
	for node in get_children():
		if node is StateCondition:
			entry_conditions.append(node)
	
func _enter_state() -> void:
	pass

func _exit_state() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _state_update(delta: float) -> void:
	pass

func self_end_state() -> void:
	state_concluded.emit()
