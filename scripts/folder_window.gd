class_name FolderWindow
extends AppWindow
## A Win95-style folder window. One scene, configured per folder: the
## title bar and toolbar tab both show `folder_name`.

## Set once at startup by the folder's desktop icon.
@export var folder_name := "New Folder"

@onready var _title: RichTextLabel = $Title
@onready var _close: Button = $"Close Button"
## Where the folder's items go. Empty for now.
@onready var contents: HFlowContainer = $Contents


func _ready() -> void:
	_title.text = folder_name
	_close.pressed.connect(close)


func _get_title() -> String:
	return folder_name
