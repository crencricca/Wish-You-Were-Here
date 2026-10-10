class_name AppWindow
extends Node2D
## Shared behavior for Win95-style desktop windows. The toolbar gives
## each one a tab while it's open.

## The toolbar adds a tab when this fires and removes it on `closed`.
signal opened
signal closed
## Fires whenever `title` changes, so the toolbar tab can follow along.
signal title_changed

## Shown on this window's toolbar tab.
@export var icon: Texture2D

## The window's full name, e.g. "Text File Editor - README.txt".
var title: String:
	get:
		return _get_title()

@onready var _frame: Control = $Frame


func open() -> void:
	show()
	move_to_front()  # draw above other open windows
	opened.emit()


## Clicking anywhere on the window brings it to the front, the same as
## clicking its toolbar tab. Runs before the GUI so buttons and text
## boxes inside the window still get the click too.
func _input(event: InputEvent) -> void:
	var click := event as InputEventMouseButton
	if click and click.pressed and is_hit_by(click) and not _is_covered(click):
		open()


## True when `click` lands on this window's frame. Every window scene
## needs a `Frame` Control covering its whole area.
func is_hit_by(click: InputEventMouseButton) -> bool:
	var local := make_input_local(click) as InputEventMouseButton
	return visible and _frame.get_rect().has_point(local.position)


## Windows later in the tree are drawn on top, so if one of them is
## hit too, the click is theirs.
func _is_covered(click: InputEventMouseButton) -> bool:
	for i in range(get_index() + 1, get_parent().get_child_count()):
		var other := get_parent().get_child(i) as AppWindow
		if other and other.is_hit_by(click):
			return true
	return false


## Hides but keeps the toolbar tab, so the window can be brought back.
func minimize() -> void:
	hide()


## Hides rather than frees, so the window keeps its state.
func close() -> void:
	hide()
	closed.emit()


## Override to build `title` from the window's contents.
func _get_title() -> String:
	return name
