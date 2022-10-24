extends Node2D

signal game_over

var energy = 3

onready var BarNode = $Bar
onready var BorderNode = $Border
onready var size_unit = BarNode.rect_size.x / 3


func _ready():
	position = Vector2(20, 20)


func _process(_delta):
	match (energy):
		3:
			_change_color("mediumseagreen")
		2:
			_change_color("orange")
		1:
			_change_color("orangered")


func _change_color(color: String):
	BarNode.rect_size.x = size_unit * energy
	BarNode.color = ColorN(color, 0.7)
	BorderNode.border_color = ColorN(color)


func _hitted():
	energy -= 1
	if energy == 0:
		emit_signal("game_over")
		energy = 3
