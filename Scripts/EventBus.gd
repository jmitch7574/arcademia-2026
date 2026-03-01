class_name EventBus
extends Node

## Game States
signal buy_time_begin
signal buy_time_end
signal battle_begin
signal battle_end(winner : PlayerStats.PLAYER)

## Shop Signals
signal reroll_requested(done_by_player : bool, for_player: PlayerStats.PLAYER)
signal purchase_requested(unit : UnitResource, source : ShopItem)
signal unit_sold(amount : int)

signal unit_killed(victim : Unit, killer : Unit, gold_reward : int)
signal unit_health_changed(unit : Unit, source : Unit, amount : float, new_health : float)

signal player_died(player : PlayerStats.PLAYER)

signal money_changed(player : PlayerStats.PLAYER, amount : int, new_value : int, cause : String)
signal levelled_up(player : PlayerStats.PLAYER, new_level : int)
