extends Node

func _on_attack_state_attacked(target: Unit) -> void:
	target.effects.append(Unit.EFFECTS.WEBBED)
