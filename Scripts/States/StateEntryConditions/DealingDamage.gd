class_name StateConditionDealingDamage
extends StateCondition

var charges = 0

@export var required_attacks = 0

@export var attack_state : AttackState

func _ready() -> void:
	GameEvents.battle_begin.connect(func(): charges = 0)
	attack_state.attack_completed.connect(func(_unit : Unit): charges += 1)

func check_condition() -> bool:
	return charges >= required_attacks

func on_state_triggered() -> void:
	charges = 0
