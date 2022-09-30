extends Node2D

onready var menu_node = preload("res://scenes/MainMenu.tscn").instance()
onready var controls_menu_node = preload("res://scenes/controls.tscn").instance()

onready var play_node = menu_node.get_node("MenuContainer/VContainer/Play")
onready var controls_node = menu_node.get_node("MenuContainer/VContainer/Controls")
enum MENU {PLAY, CONTROLS}
var selected = MENU.PLAY
var current_screen_stack = []
var is_on_control_screen = false

func _ready():
	add_child(menu_node)
	current_screen_stack.push_back(menu_node)
	play_node.modulate = Color.aqua


func _input(event: InputEvent):
	if event.is_action_pressed("ui_up") and selected == MENU.CONTROLS:
		controls_node.modulate = Color.white
		play_node.modulate = Color.aqua
		selected = MENU.PLAY
	if event.is_action_pressed("ui_down") and selected == MENU.PLAY:
		play_node.modulate = Color.white
		controls_node.modulate = Color.aqua
		selected = MENU.CONTROLS
	
	if event.is_action_pressed("ui_accept") and selected == MENU.CONTROLS and not is_on_control_screen:
		remove_child(current_screen_stack.pop_back())
		add_child(controls_menu_node)
		current_screen_stack.push_back(controls_menu_node)
		is_on_control_screen = true
		return


	if event.is_action_pressed("ui_accept") and is_on_control_screen:
		remove_child(current_screen_stack.pop_back())
		add_child(menu_node)
		current_screen_stack.push_back(menu_node)
		is_on_control_screen = false

