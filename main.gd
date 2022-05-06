extends Node2D

onready var MenuScene = load("res://scenes/Menu.tscn")
onready var ControlsScene = load("res://scenes/Controls.tscn")
onready var PlayerScene = load("res://scenes/Player.tscn")
onready var MeteorScene = load("res://scenes/Meteor.tscn")

onready var MenuNode = MenuScene.instance()
onready var ControlsNode = ControlsScene.instance()
onready var PlayerNode = PlayerScene.instance()

enum SCENE { START, CONTROLS, PLAY, GAME_OVER }
var current_selected = SCENE.START

const meteors = []

func _ready():
	add_child(MenuNode)
	add_child(ControlsNode)
	ControlsNode.visible = false
	
	for i in range(0, 10):
		meteors.append(MeteorScene.instance())
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and MenuNode.current_selected == 1 and current_selected != SCENE.CONTROLS:
		current_selected = SCENE.CONTROLS
		MenuNode.visible = false
		ControlsNode.visible = true
	elif Input.is_action_just_pressed("ui_accept") and current_selected == SCENE.CONTROLS:
		current_selected = SCENE.START
		MenuNode.visible = true
		ControlsNode.visible = false
	elif Input.is_action_just_pressed("ui_accept") and MenuNode.current_selected == 0 and current_selected == SCENE.START:
		current_selected = SCENE.PLAY
		MenuNode.visible = false
		MenuNode.Click.volume_db = -80
		add_child(PlayerNode)
		for meteor in meteors:
			add_child(meteor)
			
	for meteor in meteors:
		respawn_meteor(meteor)

func respawn_meteor(meteor):
	if meteor.position.x < 0 or meteor.position.x > 600 or meteor.position.y < 0 or meteor.position.y > 1024:
#		print(meteor.position.x)
#		meteor.queue_free()
#		meteors.erase(meteor)
		pass
