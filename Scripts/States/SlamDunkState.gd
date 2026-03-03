extends State

var slam_tween : Tween

@onready var sprite: Sprite2D = $"../../Sprite"
@onready var slam_collider: Area2D = $"../../SlamCollider"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _enter_state() -> void:
	if slam_tween: slam_tween.kill()
	slam_tween = create_tween()
	
	slam_tween.tween_property(sprite, "position", Vector2(0, -200), 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	slam_tween.tween_property(sprite, "position", Vector2(0, 0), 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN).finished.connect(func():
		for node in slam_collider.get_overlapping_areas():
			var target_unit := node.get_parent() as Unit
			if target_unit and target_unit.player_owner != unit.player_owner:
				var direction = target_unit.global_position - unit.global_position
				create_tween().tween_property(target_unit, "position", target_unit.global_position + (direction.normalized() * 300), 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
				target_unit.take_damage(12, unit)
		
		
		self_end_state()
	)
