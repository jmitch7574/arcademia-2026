extends Projectile

@onready var area: Area2D = $Area

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1).timeout
	
	queue_free()


func _on_area_area_entered(area: Area2D) -> void:
	var target_unit := area.get_parent() as Unit
	if target_unit and target_unit.player_owner != source_unit.player_owner:
		target_unit.take_damage(projectile_damage, source_unit)
