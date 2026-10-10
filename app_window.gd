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


func open() -> void:
	show()
	move_to_front()  # draw above other open windows
	opened.emit()


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
