extends Node2D

onready var BarNode = $Bar
onready var BorderNode = $Border

onready var size_unit = BarNode.rect_size.x / 3
var energy = 3

func _ready():
	position.x = 20
	position.y = 20

func _process(_delta):
	match (energy):
		3:
			change_color("mediumseagreen")
		2:
			change_color("orange")
		1:
			change_color("orangered")

func change_color(color: String):
	BarNode.rect_size.x = size_unit * energy
	BarNode.color = ColorN(color, 0.7)
	BorderNode.border_color = ColorN(color)
