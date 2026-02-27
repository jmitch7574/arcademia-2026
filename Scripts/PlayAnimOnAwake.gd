extends AnimationPlayer

@export var anim_name : String

func _ready():
	play(anim_name)
