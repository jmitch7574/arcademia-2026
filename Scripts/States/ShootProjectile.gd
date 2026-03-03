class_name ShootState
extends AttackState

@export var target_system : TargetSystem
@export var parent : Node2D
@export var sprite : Sprite2D

@export var attack_speed : float

@export var projectile : PackedScene

var offset_tween : Tween
var skew_tween : Tween

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _state_update(delta: float) -> void:
	pass

func _enter_state() -> void:
	offset_tween = create_tween()
	skew_tween = create_tween()
	
	offset_tween.tween_property(sprite, "offset", Vector2(2, 0),  0.25 / attack_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).finished.connect(func(): 
		attack_launched.emit()
		var projectile_instance = projectile.instantiate()
		
		projectile_instance.targeting_system = target_system
		projectile_instance.global_position = unit.global_position
		projectile_instance.source_unit = unit
		projectile_instance.hit_unit.connect(func(hurt_unit : Unit): attack_completed.emit(hurt_unit))
		
		get_tree().current_scene.add_child(projectile_instance)
	)
	
	offset_tween.tween_property(sprite, "offset", Vector2(0, 0),  0.25 / attack_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	skew_tween.tween_property(sprite, "skew", 0.25,  0.25 / attack_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	skew_tween.tween_property(sprite, "skew", 0,  0.25 / attack_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	offset_tween.tween_interval(0.5)
	skew_tween.tween_interval(0.5).finished.connect(func(): self_end_state())
	
	offset_tween.set_loops(0)
	skew_tween.set_loops(0)

func _exit_state() -> void:
	offset_tween.kill()
	skew_tween.kill()
	sprite.offset = Vector2(0, 0)
	sprite.skew = 0
