@tool
class_name FolderIcon
extends Node2D
## A folder on the desktop. Clicking it opens `window`, which takes on
## this icon's `folder_name` so the name only lives in one place.

## Shown under the icon, and in the window's title bar and toolbar tab.
@export var folder_name := "New Folder":
	set(value):
		folder_name = value
		if is_node_ready():
			_label.text = value
## The window this folder opens.
@export var window: FolderWindow

@onready var _label: RichTextLabel = $Name
@onready var _button: Button = $Button


## Names the window before any window's _ready runs, so it sets up
## its title with the right name no matter where it sits in the tree.
func _enter_tree() -> void:
	if window and not Engine.is_editor_hint():
		window.folder_name = folder_name


func _ready() -> void:
	_label.text = folder_name
	if Engine.is_editor_hint():
		return  # only the label should update in the editor
	_button.pressed.connect(_on_pressed)


func _on_pressed() -> void:
	if window:
		window.open()
