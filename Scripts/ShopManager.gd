class_name ShopManager
extends PanelContainer

@export var reroll_button : RerollButton
@export var levelup_button : LevelUpButton
@export var shop_item : ShopItem

@export var shop_queue : ShopQueue
@export var player_stats : PlayerStats

@onready var shop_sfx_manager: ShopSFXManager = $ShopSFXManager

signal process_player_skip(player : PlayerStats.PLAYER)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.buy_time_begin.connect(process_reroll)
	levelup_button.update_price_text(player_stats.get_level_up_cost())
	
	process_reroll()

func process_reroll(was_requested_by_player : bool = false):
	if GameStateManager.current_state != GameStateManager.GAMESTATE.BUY_TIME: return
	
	if (reroll_button.reroll_price > player_stats.money):
		shop_sfx_manager.play_buzzer()
		return
	
	shop_item.current_unit = null
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

func process_skip_request():
	process_player_skip.emit(player_stats.player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
