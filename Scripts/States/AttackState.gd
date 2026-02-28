class_name AttackState
extends State

@export var target_system : TargetSystem
@export var parent : Node2D
@export var sprite : Sprite2D

@export var attack_speed : float
@export var attack_range : float
@export var damage : int = 10

var offset_tween : Tween
var skew_tween : Tween

signal attacked

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _state_update(delta: float) -> void:
	pass

## Function that decides whether or not this state can be transitioned to
func state_entry_condition() -> bool:
	return parent.global_position.distance_to(target_system.get_target().global_position) < attack_range

func _enter_state() -> void:
	offset_tween = create_tween()
	skew_tween = create_tween()
	
	offset_tween.tween_property(sprite, "offset", Vector2(5, 0),  0.25 / attack_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	offset_tween.tween_property(sprite, "offset", Vector2(0, 0),  0.25 / attack_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).finished.connect(func(): attacked.emit())
	
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
