extends Node

func _on_play_button_pressed() -> void:
	SceneTransitioner.move_to_scene("res://TutorialScene.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
