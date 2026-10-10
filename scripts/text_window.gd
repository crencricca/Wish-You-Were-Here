class_name TextWindow
extends AppWindow
## A Win95-style text file window. One scene, configured per instance:
## README is read-only, Notes is editable. Closing only hides it, so
## anything typed into Notes is kept.

const APP_NAME := "Text File Editor"

## Shown in the title bar, e.g. "README.txt". Set once at startup by
## the file's desktop icon.
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
	super()
	if not read_only:
		_editor.grab_focus()


func _get_title() -> String:
	return "%s - %s" % [APP_NAME, file_name]
