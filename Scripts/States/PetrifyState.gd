extends State

@onready var petrification_zone: Area2D = $"../../PetrificationZone"
@onready var petrification_particles: GPUParticles2D = $"../../PetrificationParticles"

var those_who_were_petrified : Array[Unit]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _enter_state() -> void:
	those_who_were_petrified = []
	petrification_particles.emitting = true
	
	for node in petrification_zone.get_overlapping_areas():
		var target_unit := node.get_parent() as Unit
		if target_unit and target_unit != unit and target_unit.player_owner != unit.player_owner:
			print(target_unit.name)
			those_who_were_petrified.append(target_unit)
			target_unit.get_node("StateMachine").swap_state_by_name("Petrified")
	
	self_end_state()
