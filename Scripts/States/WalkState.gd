class_name WalkState
extends State

@export var target_system : TargetSystem
@export var parent : Node2D
@export var move_speed : float
@export var sprite : Sprite2D

## The rate in which movement speeds converts into animation speed, higher value = faster
const MOVE_SPEED_TWEEN_COEFFICIENT = 50

var walk_tween : Tween

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _state_update(delta: float) -> void:
	if target_system.get_target():
		var speed = delta * move_speed
		
		if unit.EFFECTS.has(Unit.EFFECTS.WEBBED):
			speed * 0.8
		
		parent.global_position = parent.global_position.move_toward(target_system.get_target().global_position, speed)

## Function that decides whether or not this state can be transitioned to
func state_entry_condition() -> bool:
	return true

func _enter_state() -> void:
	walk_tween = create_tween()
	walk_tween.tween_property(sprite, "rotation_degrees", 25,  MOVE_SPEED_TWEEN_COEFFICIENT / move_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	walk_tween.tween_property(sprite, "rotation_degrees", 0,   MOVE_SPEED_TWEEN_COEFFICIENT / move_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	walk_tween.tween_property(sprite, "rotation_degrees", -25, MOVE_SPEED_TWEEN_COEFFICIENT / move_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	walk_tween.tween_property(sprite, "rotation_degrees", 0,   MOVE_SPEED_TWEEN_COEFFICIENT / move_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	walk_tween.set_loops(0)

func _exit_state() -> void:
	walk_tween.kill()
	sprite.rotation_degrees = 0
