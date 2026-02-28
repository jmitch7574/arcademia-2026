class_name ShopManager
extends PanelContainer

@onready var shop_elements: HBoxContainer = $MarginContainer/ShopElements

const REROLL = preload("uid://b2n21l6pwilj3")
const SHOP_ITEM = preload("uid://uu0p10ftnw1r")
const LEVEL_UP = preload("uid://b0xmg8pvy5yqy")

var reroll_button : RerollButton
var levelup_button : LevelUpButton
var shop_items : Array[ShopItem]

@export var shop_queue : ShopQueue
@export var player_stats : PlayerStats

@onready var shop_sfx_manager: ShopSFXManager = $ShopSFXManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reroll_button = REROLL.instantiate()
	shop_elements.add_child(reroll_button)
	
	if reroll_button is RerollButton:
		reroll_button.reroll_requested.connect(process_reroll.bind(true))
		GameEvents.buy_time_begin.connect(process_reroll)
	
	for i in range(0, 1):
		var shop_item = SHOP_ITEM.instantiate()
		shop_elements.add_child(shop_item)
		
		if shop_item is ShopItem:
			shop_item.purchase_requested.connect(process_purchase)
			shop_items.append(shop_item)
	
	levelup_button = LEVEL_UP.instantiate()
	shop_elements.add_child(levelup_button)
	
	if levelup_button is LevelUpButton:
		levelup_button.levelup_requested.connect(process_levelup)
		levelup_button.update_price_text(player_stats.get_level_up_cost())
	
	process_reroll()

func process_reroll(was_requested_by_player : bool = false):
	if GameStateManager.current_state != GameStateManager.GAMESTATE.BUY_TIME: return
	
	if (reroll_button.reroll_price > player_stats.money):
		shop_sfx_manager.play_buzzer()
		return
	
	for shop_item in shop_items:
		shop_item.current_unit = null
	
	for shop_item in shop_items:
		shop_item.bootstrap(shop_queue.get_next_unit())
	
	if (was_requested_by_player):
		player_stats.update_money(-reroll_button.reroll_price)
		reroll_button.reroll_successful()
		shop_sfx_manager.play_reroll() 

func process_levelup():
	if GameStateManager.current_state != GameStateManager.GAMESTATE.BUY_TIME: return
	
	if (player_stats.get_level_up_cost() > player_stats.money):
		shop_sfx_manager.play_buzzer()
		return
	
	player_stats.update_money(-player_stats.get_level_up_cost())
	player_stats.level_up()
	levelup_button.levelup_successful()
	levelup_button.update_price_text(player_stats.get_level_up_cost())
	shop_sfx_manager.play_level_up()

func process_purchase(unit : UnitResource, source : ShopItem):
	if GameStateManager.current_state != GameStateManager.GAMESTATE.BUY_TIME or unit == null:
		return
	
	if player_stats.money < unit.unit_cost:
		shop_sfx_manager.play_buzzer()
		return
	
	if player_stats.get_unit_count() >= player_stats.player_level:
		shop_sfx_manager.play_buzzer()
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
