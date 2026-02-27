extends PanelContainer

@onready var shop_elements: HBoxContainer = $MarginContainer/ShopElements

const REROLL = preload("uid://b2n21l6pwilj3")
const SHOP_ITEM = preload("uid://uu0p10ftnw1r")

var shop_items : Array[ShopItem]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var reroll_item = REROLL.instantiate()
	shop_elements.add_child(reroll_item)
	
	if reroll_item is RerollButton:
		reroll_item.reroll_requested.connect(process_reroll)
	
	for i in range(0, 3):
		var shop_item = SHOP_ITEM.instantiate()
		shop_elements.add_child(shop_item)
		
		if shop_item is ShopItem:
			shop_item.purchase_requested.connect(process_purchase)
			shop_items.append(shop_item)

func process_reroll():
	pass

func process_purchase():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
