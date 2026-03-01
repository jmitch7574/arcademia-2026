class_name ShopQueue
extends Node

@export var units : Array[UnitResource]

var random_seed = 42
var random_object : RandomNumberGenerator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random_object = RandomNumberGenerator.new()
	
	if OS.has_feature("demonstration") or OS.has_feature("editor"):
		random_object.seed = 1738


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_available_units() -> Array[UnitResource]:
	var available_units = units.duplicate(true)
	
	for unit in get_tree().get_nodes_in_group("Units"):
		if (unit is Unit):
			available_units.erase(unit.unit_resource)
	
	for unit in get_tree().get_nodes_in_group("ShopItems"):
		if unit is ShopItem:
			available_units.erase(unit.current_unit)
	
	return available_units

func get_next_unit() -> UnitResource:
	var available_units = get_available_units()
	
	if len(available_units) == 0:
		return null
	
	return available_units[random_object.randi_range(0, len(available_units) - 1)]
