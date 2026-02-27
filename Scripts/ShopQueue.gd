extends Node

@export var units : Array[UnitResource]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_available_units() -> Array[UnitResource]:
	var available_units = units.duplicate(true)
	
	for unit in get_tree().get_nodes_in_group("Units"):
		if (unit is Unit):
			available_units.erase(unit.unit_resource)
	
	return available_units
