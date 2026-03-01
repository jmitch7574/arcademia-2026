extends Projectile

@onready var area: Area2D = $Area

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in area.get_overlapping_areas():
		var target_unit := node.get_parent() as Unit
		if target_unit and target_unit.player_owner != source_unit.player_owner:
			target_unit.take_damage(projectile_damage, source_unit)

	await get_tree().create_timer(1).timeout
	
	queue_free()
