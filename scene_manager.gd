extends Node2D


onready var game_over_scene = preload("res://menus/GameOver.tscn")
onready var menu_node = preload("res://menus/Main.tscn").instance()
onready var controls_menu_node = preload("res://menus/controls.tscn").instance()

onready var player_node = preload("res://player/player.tscn").instance()
onready var meteor_spawner_node = preload("res://meteor/meteor_spawner.tscn").instance()
onready var energy_node = preload("res://hud/Energy.tscn").instance()
onready var score_node = preload("res://hud/Score.tscn").instance()

onready var play_node = menu_node.get_node("MenuContainer/VContainer/Play")
onready var controls_node = menu_node.get_node("MenuContainer/VContainer/Controls")

onready var game_over_node = game_over_scene.instance()

enum MENU {PLAY, CONTROLS}

var selected = MENU.PLAY
var current_screen_stack = []
var is_on_control_screen = false
var is_on_play_screen = false
var is_on_game_over_screen = false


func _ready():
	OS.window_maximized = true
	add_child(menu_node)
	current_screen_stack.push_back(menu_node)
	play_node.modulate = Color.aqua


func _input(event: InputEvent):
	if event.is_action_pressed("shake"):
		$Camera.apply_noise_shake()
	if is_on_play_screen:
		return
	
	if event.is_action_pressed("ui_accept") and is_on_game_over_screen:
		remove_child(game_over_node)
		add_child(menu_node)
		current_screen_stack.push_back(menu_node)
		play_node.modulate = Color.aqua
		is_on_game_over_screen = false
		player_node = preload("res://player/player.tscn").instance()
		$BGM.play()
		return

	if event.is_action_pressed("ui_up") and selected == MENU.CONTROLS:
		controls_node.modulate = Color.white
		play_node.modulate = Color.aqua
		selected = MENU.PLAY
		$Click.play()

	if event.is_action_pressed("ui_down") and selected == MENU.PLAY:
		play_node.modulate = Color.white
		controls_node.modulate = Color.aqua
		selected = MENU.CONTROLS
		$Click.play()
	
	if event.is_action_pressed("ui_accept") and selected == MENU.PLAY:
		remove_child(current_screen_stack.pop_back())
		player_node.get_child(0).connect("hitted", energy_node, "_hitted")
		player_node.get_child(0).connect("hitted", $Camera, "apply_noise_shake")
		add_child(player_node)
		add_child(meteor_spawner_node)
		add_child(energy_node)
		add_child(score_node)
		energy_node.connect("game_over", self, "_game_over")
		is_on_play_screen = true
		$Click.play()
		return
	
	if event.is_action_pressed("ui_accept") and selected == MENU.CONTROLS and not is_on_control_screen:
		remove_child(current_screen_stack.pop_back())
		add_child(controls_menu_node)
		current_screen_stack.push_back(controls_menu_node)
		is_on_control_screen = true
		$Click.play()
		return

	if event.is_action_pressed("ui_accept") and is_on_control_screen:
		remove_child(current_screen_stack.pop_back())
		add_child(menu_node)
		current_screen_stack.push_back(menu_node)
		is_on_control_screen = false
		$Click.play()


func _game_over():
	remove_child(player_node)
	player_node.queue_free()
	remove_child(meteor_spawner_node)
	remove_child(energy_node)
	remove_child(score_node)
	add_child(game_over_node)
	var total_score_node = game_over_node.get_node("MenuContainer/VContainer/TotalScore")
	total_score_node.bbcode_text = "[center]Total Score: [color=aqua]%d[/color][/center]" % score_node.get_child(0).score
	score_node.get_child(0).on_reset()
	is_on_game_over_screen = true
	is_on_play_screen = false
	$BGM.stop()
	$Lose.play()
