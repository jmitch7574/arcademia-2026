class_name State
extends Node

@export var interruptible : bool


## Function that decides whether or not this state can be transitioned to
func state_entry_condition() -> bool:
	return false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
