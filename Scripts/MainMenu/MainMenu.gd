extends Node

func _on_play_button_pressed() -> void:
	SceneTransitioner.move_to_scene("res://GameScene.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
