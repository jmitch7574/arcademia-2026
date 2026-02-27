class_name ShopItem
extends InteractableControl

@onready var unit_name: RichTextLabel = $ShopBottom/UnitName
@onready var unit_texture: TextureRect = $UnitTexture

signal purchase_requested

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func bootstrap(unit: UnitResource):
	unit_name.text = unit.unit_name
	unit_texture.texture = unit.unit_sprite


func _on_press() -> void:
	pass
