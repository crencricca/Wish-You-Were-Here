extends Node2D

## Scene the Start button loads.
@export_file("*.tscn") var game_scene: String = "res://scenes/desktop.tscn"


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(game_scene)


func _on_exit_pressed() -> void:
	get_tree().quit()
