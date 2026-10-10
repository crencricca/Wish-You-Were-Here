extends Node2D
## Owns the game's top-level screens. Swaps one screen for the next
## with a short fade, freeing the old one so it stops running.

const START_SCENE := preload("res://scenes/start.tscn")
const DESKTOP_SCENE := preload("res://scenes/desktop.tscn")
const FADE_TIME := 0.35

var _current: Node
var _transitioning := false

@onready var _fade: ColorRect = $Fade/Rect


func _ready() -> void:
	var start := START_SCENE.instantiate()
	start.start_requested.connect(_on_start_requested)
	_swap_to(start)


func _on_start_requested() -> void:
	await change_screen(DESKTOP_SCENE)


## Fades to black, replaces the current screen, then fades back in.
func change_screen(scene: PackedScene) -> void:
	if _transitioning:
		return
	_transitioning = true
	_fade.mouse_filter = Control.MOUSE_FILTER_STOP  # block clicks mid-fade
	await _fade_to(1.0)
	_swap_to(scene.instantiate())
	await _fade_to(0.0)
	_fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_transitioning = false


func _swap_to(next: Node) -> void:
	if _current:
		_current.queue_free()
	add_child(next)
	_current = next


func _fade_to(alpha: float) -> void:
	var tween := create_tween()
	tween.tween_property(_fade, "color:a", alpha, FADE_TIME)
	await tween.finished
