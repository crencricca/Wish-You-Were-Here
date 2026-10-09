class_name TextWindow
extends Node2D
## A Win95-style text file window. One scene, configured per instance:
## README is read-only, Notes is editable.

## Shown in the title bar, e.g. "README.txt".
@export var file_name := "Untitled.txt"
## When on, the player can read and select text but not change it.
@export var read_only := false
## The file's starting contents.
@export_multiline var body := ""

@onready var _title: RichTextLabel = $"File Name"
@onready var _editor: TextEdit = $"Text Editor"
@onready var _close: Button = $"Close Button"


func _ready() -> void:
	_title.text = file_name
	_editor.text = body
	_editor.editable = not read_only
	_close.pressed.connect(close)


func open() -> void:
	show()
	move_to_front()  # draw above other open windows
	if not read_only:
		_editor.grab_focus()


## Hides rather than frees, so anything typed into Notes is kept.
func close() -> void:
	hide()
