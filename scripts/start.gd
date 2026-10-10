extends Node2D

## Main listens for this and swaps to the desktop.
signal start_requested


func _ready() -> void:
	# Start is the only option on the screen, so keep it selected:
	# the green bar shows right away and Enter/Space activates it.
	$Start.grab_focus()


func _on_start_pressed() -> void:
	start_requested.emit()


func _on_exit_pressed() -> void:
	get_tree().quit()
