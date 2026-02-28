class_name LokiProjectile
extends Projectile

@onready var particle_trail: GPUParticles2D = $ParticleTrail
@onready var particle_hit: GPUParticles2D = $ParticleHit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!targeting_system.get_target()):
		queue_free()
		return
	global_position = global_position.move_toward(targeting_system.get_target().global_position, projectile_speed * delta)
	
	
	if global_position.distance_to(targeting_system.get_target().global_position) < 1:
		particle_trail.emitting = false
		particle_hit.emitting = true
		
		particle_hit.reparent(get_tree().current_scene)
		
		targeting_system.get_target().take_damage(projectile_damage, source_unit)
		
		queue_free()
		
		
