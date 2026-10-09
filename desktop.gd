extends Node2D

@onready var _readme: TextWindow = $"README App"


func _on_readme_icon_pressed() -> void:
	_readme.open()
