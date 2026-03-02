extends Projectile

@onready var hitbox: Area2D = $Hitbox

var tick = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(3).timeout
	
	queue_free()

func _draw() -> void:
	draw_circle(Vector2(0, 0), 150, Color("#ff000033"), true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tick -= delta
	if tick <= 0:
		tick = 0.25
		for node in hitbox.get_overlapping_areas():
			var target_unit := node.get_parent() as Unit
			if target_unit and target_unit.player_owner != source_unit.player_owner:
				target_unit.take_damage(ceil(projectile_damage / 4), source_unit)
