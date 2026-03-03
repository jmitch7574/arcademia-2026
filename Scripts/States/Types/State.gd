class_name State
extends Node

@export var interruptible : bool
@export var entry_condition : StateCondition
var unit : Unit

signal state_concluded

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _enter_state() -> void:
	pass

func _exit_state() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _state_update(delta: float) -> void:
	pass

func self_end_state() -> void:
	state_concluded.emit()
