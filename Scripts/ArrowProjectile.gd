extends Projectile

var direction : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var target = targeting_system.get_target()
	
	if target:
		direction = (target.global_position - global_position).normalized()
		look_at(global_position + direction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * projectile_speed * delta


func _on_collision_area_entered(area: Area2D) -> void:
	var unit := area.get_parent() as Unit
	if unit and area.is_in_group("UnitHitbox"):
		if unit.player_owner == source_unit.player_owner:
			return
		
		unit.take_damage(projectile_damage, source_unit)
		queue_free()
