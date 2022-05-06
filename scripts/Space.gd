extends ColorRect

onready var StarScene = load("res://scenes/Star.tscn")

func _ready():
	for _i in range(100):
		add_child(StarScene.instance())
