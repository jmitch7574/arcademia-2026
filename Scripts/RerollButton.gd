class_name RerollButton
extends InteractableControl

signal reroll_requested

@onready var texture_rect: TextureRect = $TextureRect
@onready var reroll_text: RichTextLabel = $RerollBottom/RerollText

var reroll_price = 3

var rotation_anim : Tween

func _ready() -> void:
	GameEvents.buy_time_begin.connect(func(): 
		reroll_price = 3
		update_price_text()
	)
	update_price_text()

func _on_press() -> void:
	reroll_requested.emit()

func reroll_successful() -> void:
	reroll_price += 2
	if rotation_anim: rotation_anim.stop()
	texture_rect.rotation_degrees = 0
	rotation_anim = create_tween()
	rotation_anim.tween_property(texture_rect, "rotation_degrees", 360, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	update_price_text()

func update_price_text():
	reroll_text.text = "REROLL [img]res://Assets/money.png[/img][color=#ffd24b]" + str(reroll_price) + "[/color]"
