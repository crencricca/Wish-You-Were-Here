class_name Toolbar
extends Node2D
## The Win95 taskbar along the bottom of the desktop. Every open window
## gets a tab; clicking a tab brings its window to the front, or
## minimizes it if it's already the active one.

## Tabs shrink to share the bar once there are too many to fit.
const MAX_TAB_WIDTH := 160.0

var _tabs := {}  # window -> its tab Button
var _active: Node

@onready var _tab_row: HBoxContainer = $Tabs
@onready var _template: Button = $TabTemplate
@onready var _start_menu: Node2D = $"Start Menu"


## Gives `window` a tab while it's open.
func track(window: AppWindow) -> void:
	window.opened.connect(_on_window_opened.bind(window))
	window.closed.connect(_on_window_closed.bind(window))
	if window.visible:
		_on_window_opened(window)

func get_window_name(window: Node):
	if (window is TextWindow): 
		return window.title.replace('Text File Editor - ', '');
	return window.title;

func _on_window_opened(window: Node) -> void:
	if not _tabs.has(window):
		var tab: Button = _template.duplicate()
		tab.icon = window.icon
		tab.text = get_window_name(window)
		tab.tooltip_text = window.title  # full name when it's cut off
		tab.show()
		tab.pressed.connect(_on_tab_pressed.bind(window))
		_tab_row.add_child(tab)
		_tabs[window] = tab
		_fit_tabs()
	_set_active(window)


func _on_window_closed(window: Node) -> void:
	if not _tabs.has(window):
		return
	_tabs[window].queue_free()
	_tabs.erase(window)
	if window == _active:
		_set_active(null)
	_fit_tabs()


func _on_tab_pressed(window: Node) -> void:
	if window == _active and window.visible:
		window.minimize()
		_set_active(null)
	else:
		window.open()  # emits opened, which makes it active


## Only the active window's tab looks pushed in.
func _set_active(window: Node) -> void:
	_active = window
	for w in _tabs:
		_tabs[w].set_pressed_no_signal(w == window)


func _fit_tabs() -> void:
	if _tabs.is_empty():
		return
	var count := _tabs.size()
	var gaps := _tab_row.get_theme_constant("separation") * (count - 1)
	var width := minf(MAX_TAB_WIDTH, (_tab_row.size.x - gaps) / count)
	for tab: Button in _tabs.values():
		tab.custom_minimum_size.x = width


## The Start button stays pushed in while the menu is open.
func _on_start_button_toggled(toggled_on: bool) -> void:
	_start_menu.visible = toggled_on


## Quits the game, the same as the power button on the start screen.
func _on_shut_down_pressed() -> void:
	get_tree().quit()
