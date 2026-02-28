class_name ShopManager
extends PanelContainer

@onready var shop_elements: HBoxContainer = $MarginContainer/ShopElements

const REROLL = preload("uid://b2n21l6pwilj3")
const SHOP_ITEM = preload("uid://uu0p10ftnw1r")

var shop_items : Array[ShopItem]

@export var shop_queue : ShopQueue
@export var player_stats : PlayerStats

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
	
	process_reroll()

func process_reroll(button : RerollButton = null):
	if GameStateManager.current_state != GameStateManager.GAMESTATE.BUY_TIME: return
	
	for shop_item in shop_items:
		shop_item.current_unit = null
	
	for shop_item in shop_items:
		shop_item.bootstrap(shop_queue.get_next_unit())
	
	if (button):
		player_stats.update_money(-button.reroll_price)
		button.reroll_price += 1

func process_purchase(unit : UnitResource, source : ShopItem):
	if GameStateManager.current_state != GameStateManager.GAMESTATE.BUY_TIME or unit == null:
		return
	
	if player_stats.money < unit.unit_cost:
		return
	
	player_stats.update_money(-unit.unit_cost)
	
	var newUnit = unit.unit_scene.instantiate()
	newUnit.player_owner = player_stats.player
	newUnit.unit_resource = unit
	get_tree().current_scene.add_child(newUnit)
	source.bootstrap(null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
