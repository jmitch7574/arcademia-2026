class_name ShopItem
extends InteractableControl

@onready var unit_name: RichTextLabel = $ShopBottom/UnitName
@onready var unit_texture: TextureRect = $UnitTexture
const CROSS = preload("uid://bgxcdvndubylk")

var current_unit : UnitResource

signal purchase_requested(unit : UnitResource, source : ShopItem)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func bootstrap(unit: UnitResource):
	if unit == null:
		unit_name.text = "SOLD OUT"
		unit_texture.texture = CROSS
		return
	
	unit_name.text = unit.unit_name + " [img]res://Assets/money.png[/img][color=#ffd24b]" + str(unit.unit_cost) + "[/color]"
	unit_texture.texture = unit.unit_sprite
	
	current_unit = unit


func _on_press() -> void:
	purchase_requested.emit(current_unit, self)
