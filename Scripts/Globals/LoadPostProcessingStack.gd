extends Node

const POST_PROCESSING_STACK = preload("uid://pw7n4blqlkbj")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = POST_PROCESSING_STACK.instantiate()
	add_child(instance)
