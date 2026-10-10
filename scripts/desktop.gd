extends Node2D

@onready var _toolbar: Toolbar = $Toolbar


## Every window on the desktop gets a toolbar tab while it's open.
func _ready() -> void:
	for child in get_children():
		if child is AppWindow:
			_toolbar.track(child)
