@tool
class_name TextFileIcon
extends Node2D
## A text file on the desktop. Clicking it opens `window`, which takes
## on this icon's `file_name` so the name only lives in one place.

## The window's file name, e.g. "Notes.txt". The label under the icon
## leaves off the extension.
@export var file_name := "Untitled.txt":
	set(value):
		file_name = value
		if is_node_ready():
			_label.text = value.get_basename()
## The window this file opens.
@export var window: TextWindow

@onready var _label: RichTextLabel = $Name
@onready var _button: Button = $Button


## Names the window before any window's _ready runs, so it sets up
## its title with the right name no matter where it sits in the tree.
func _enter_tree() -> void:
	if window and not Engine.is_editor_hint():
		window.file_name = file_name


func _ready() -> void:
	_label.text = file_name.get_basename()
	if Engine.is_editor_hint():
		return  # only the label should update in the editor
	_button.pressed.connect(_on_pressed)


func _on_pressed() -> void:
	if window:
		window.open()
