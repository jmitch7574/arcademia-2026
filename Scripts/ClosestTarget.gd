class_name ClosestTarget
extends TargetSystem

## Get Closest Target
func get_new_target():
	var closest_unit: Unit = null
	var closest_distance: float = INF
	
	for unit in get_tree().get_nodes_in_group("Units"):
		if unit == get_parent():
			continue
		var distance = global_position.distance_to(unit.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_unit = unit

	return closest_unit
