extends State

@onready var petrification_zone: Area2D = $"../../PetrificationZone"
@onready var petrification_particles: GPUParticles2D = $"../../PetrificationParticles"

var those_who_were_petrified : Array[Unit]

var charges = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

## Function that decides whether or not this state can be transitioned to
func state_entry_condition() -> bool:
	return charges >= 5
	
func _enter_state() -> void:
	charges = 0
	those_who_were_petrified = []
	petrification_particles.emitting = true
	
	for node in petrification_zone.get_overlapping_areas():
		var target_unit := node.get_parent() as Unit
		if target_unit and target_unit != unit:
			print(target_unit.name)
			those_who_were_petrified.append(target_unit)
			target_unit.get_node("StateMachine").swap_state_by_name("Petrified")
	
	self_end_state()
	

func _exit_state() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _state_update(delta: float) -> void:
	pass


func _on_attack_state_attacked(target: Unit) -> void:
	charges += 1
	
