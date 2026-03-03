class_name StateConditionHealth
extends StateCondition

enum COMPARISON
{
	MORE_THAN,
	LESS_THAN,
	EQUAL,
	MAX_HEALTH,
	DEAD
}

@export var comparison : COMPARISON
@export var health_value : int
@export var unit : Unit

func check_condition() -> bool:
	match comparison:
		COMPARISON.MORE_THAN:
			return unit.health > health_value
		COMPARISON.LESS_THAN:
			return unit.health < health_value
		COMPARISON.MAX_HEALTH:
			return unit.health == unit.max_health
		COMPARISON.DEAD:
			return unit.health <= 0
		_:
			return false
