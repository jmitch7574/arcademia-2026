class_name State
extends Node

@export var interruptible : bool

signal state_concluded

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

## Function that decides whether or not this state can be transitioned to
func state_entry_condition() -> bool:
	return false
	
func _enter_state() -> void:
	pass

func _exit_state() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _state_update(delta: float) -> void:
	pass

func self_end_state() -> void:
	state_concluded.emit()
