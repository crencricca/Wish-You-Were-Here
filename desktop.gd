extends Node2D

@onready var _readme: TextWindow = $"README App"
@onready var _toolbar: Toolbar = $Toolbar


func _ready() -> void:
	_toolbar.track(_readme)
	for child in get_children():
		if child is FolderIcon and child.window:
			_toolbar.track(child.window)


func _on_readme_icon_pressed() -> void:
	_readme.open()
