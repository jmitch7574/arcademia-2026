class_name LevelUpButton
extends InteractableControl

signal levelup_requested

@onready var texture_rect: TextureRect = $TextureRect
@onready var levelup_text: RichTextLabel = $LevelUpButton/LevelUpText

var size_anim : Tween

func _ready() -> void:
	pass

func _on_press() -> void:
	levelup_requested.emit()

func levelup_successful() -> void:
	if size_anim: size_anim.stop()
	size_anim = create_tween()
	texture_rect.scale = Vector2(1.4, 1.4)
	size_anim.tween_property(texture_rect, "scale", Vector2(1, 1), 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func update_price_text(price : int):
	levelup_text.text = "LEVEL UP [img]res://Assets/money.png[/img][color=#ffd24b]" + str(price) + "[/color]"
