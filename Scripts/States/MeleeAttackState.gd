class_name MeleeAttackState
extends AttackState

@export var target_system : TargetSystem
@export var parent : Node2D
@export var sprite : Sprite2D

@export var attack_speed : float
@export var damage : int = 10

var offset_tween : Tween
var skew_tween : Tween

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _state_update(delta: float) -> void:
	pass

func _enter_state() -> void:
	attack_launched.emit()
	offset_tween = create_tween()
	skew_tween = create_tween()
	
	offset_tween.tween_property(sprite, "offset", Vector2(5, 0),  0.25 / attack_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	offset_tween.tween_property(sprite, "offset", Vector2(0, 0),  0.25 / attack_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).finished.connect(func(): 
		var target = target_system.get_target()
		if is_instance_valid(target):
			attack_completed.emit(target)
			target.take_damage(damage, unit)
	)
	
	skew_tween.tween_property(sprite, "skew", 0.5,  0.25 / attack_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
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
