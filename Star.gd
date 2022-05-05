extends Node2D

var color = ColorN("white", 0.3)
var radius = 0
var center = Vector2.ZERO

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	radius = rng.randi_range(1, 3)
	var x = rng.randi_range(0, 1024)
	var y = rng.randi_range(0, 600)
	center = Vector2(x, y)

func _draw():
	draw_circle(center, radius, color)

func _process(_delta):
	center.x = wrapi(center.x + 1, 0, 1024)
	center.y = wrapi(center.y + 1, 0, 600)
	update()
