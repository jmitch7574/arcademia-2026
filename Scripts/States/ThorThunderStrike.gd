extends State

@export var target_system : TargetSystem
@export var damage : int = 20
const LIGHTNING_VFX = preload("uid://bn4s7iijx68dg")

var charges = 0

## Function that decides whether or not this state can be transitioned to
func state_entry_condition() -> bool:
	return charges >= 3
	
func _enter_state() -> void:
	charges = 0
	if target_system.get_target():
		var position = target_system.get_target().global_position
		target_system.get_target().take_damage(damage)

		var newVFX = LIGHTNING_VFX.instantiate()
		newVFX.global_position = position
		get_tree().current_scene.add_child(newVFX)
		
	self_end_state()

func _exit_state() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _state_update(delta: float) -> void:
	pass

func _on_attack_state_attacked() -> void:
	charges += 1
