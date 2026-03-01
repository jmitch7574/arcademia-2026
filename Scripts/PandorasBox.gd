extends Node2D

@export var state_manager : GameStateManager

@export var tier_one_enemies : Array[PackedScene]
@export var tier_two_enemies : Array[PackedScene]

@export var tier_two_chance : Curve
@export var slots_curve : Curve

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func spawn_enemies():
	var slots = floor(slots_curve.sample(state_manager.round))
	
	while slots > 0:
		var chosen_enemy
		
		if randf() < tier_two_chance.sample(state_manager.round):
			slots -= 2
			chosen_enemy = tier_two_enemies[randi_range(0, len(tier_two_enemies) - 1)]
		else:
			slots -= 1
			chosen_enemy = tier_one_enemies[randi_range(0, len(tier_one_enemies) - 1)]
			
		var instance_enemy = chosen_enemy.instantiate()
		get_tree().current_scene.add_child(instance_enemy)
		
		await get_tree().create_timer(2.0 / state_manager.round).timeout

func on_battle_about_to_begin():
	await get_tree().create_timer(1).timeout
	
	animation_player.play("to_fire")
	
	await get_tree().create_timer(0.2).timeout
	
	animation_player.play("firing")
	
	await spawn_enemies()
	
	var previous_pos = animation_player.current_animation_position
	while true:
		await get_tree().process_frame
		
		var current_pos = animation_player.current_animation_position
		
		if current_pos < previous_pos:
			break
		
		previous_pos = current_pos
	
	animation_player.play_backwards("to_fire")
	
	await animation_player.animation_finished
	
	animation_player.play("idle")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("idle")
	GameEvents.buy_time_end.connect(on_battle_about_to_begin)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
