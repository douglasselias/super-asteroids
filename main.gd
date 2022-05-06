extends Node2D

onready var MenuScene = load("res://scenes/Menu.tscn")
onready var ControlsScene = load("res://scenes/Controls.tscn")
onready var PlayerScene = load("res://scenes/Player.tscn")
onready var MeteorScene = load("res://scenes/Meteor.tscn")
onready var ExplosionScene = load("res://scenes/Explosion.tscn")
onready var EnergyScene = load("res://scenes/Energy.tscn")
onready var GameOverScene = load("res://scenes/GameOver.tscn")

onready var MenuNode = MenuScene.instance()
onready var ControlsNode = ControlsScene.instance()
onready var PlayerNode = PlayerScene.instance()
onready var EnergyNode = EnergyScene.instance()
onready var GameOverNode = GameOverScene.instance()

enum SCENE { START, CONTROLS, PLAY, GAME_OVER }
var current_selected = SCENE.START

const meteors = []
onready var BgMusicNode = $BgMusic

func _ready():
	add_child(MenuNode)
	add_child(ControlsNode)
	add_child(GameOverNode)
	ControlsNode.visible = false
	GameOverNode.visible = false	
	
	for i in range(0, 10):
		meteors.append(MeteorScene.instance())
	
func _process(_delta):
	if not BgMusicNode.playing and current_selected == SCENE.START:
		BgMusicNode.play()

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
		
		if is_instance_valid(PlayerNode):
			add_child(PlayerNode)
		else:
			print("create node")
			PlayerNode = PlayerScene.instance()
			add_child(PlayerNode)
		if is_instance_valid(EnergyNode):
			add_child(EnergyNode)
		else:
			EnergyNode = EnergyScene.instance()
			add_child(EnergyNode)
			
		PlayerNode.connect("hit", self, "_on_hit")
		if meteors.size() == 0:
			print("empty array")
			for i in range(0, 10):
				var meteor = MeteorScene.instance()
				meteors.append(meteor)
				add_child(meteor)
		else:
			for meteor in meteors:
				add_child(meteor)
	elif Input.is_action_just_pressed("ui_accept") and current_selected == SCENE.GAME_OVER:
		current_selected = SCENE.START
		MenuNode.visible = true
		GameOverNode.visible = false

	for meteor in meteors:
		respawn_meteor(meteor)

func respawn_meteor(meteor):
	if meteor.destroy:
		var pos = meteor.position
		meteor.queue_free()
		meteors.erase(meteor)
		
		var new_meteor = MeteorScene.instance()
		meteors.append(new_meteor)
		add_child(new_meteor)
		
		var explosionNode = ExplosionScene.instance()
		explosionNode.position = pos
		add_child(explosionNode)
		
func _on_hit():
	EnergyNode.energy -= 1
	if EnergyNode.energy == 0:
		current_selected = SCENE.GAME_OVER
		GameOverNode.visible = true

		PlayerNode.queue_free()
		EnergyNode.queue_free()

		for meteor in meteors:
			meteor.queue_free()
		
		meteors.clear()
		BgMusicNode.stop()
		
