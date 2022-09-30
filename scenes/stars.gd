extends Node2D

const stars = []
onready var rng = RandomNumberGenerator.new()
onready var viewport_size = get_viewport().size

func _ready():
	VisualServer.set_default_clear_color(Color.black)

	for i in 100:
		stars.push_back(_create_star())


func _draw():
	for star in stars:
		draw_circle(star.center, star.radius, ColorN("white", 0.3))


func _process(_delta):
	for star in stars:
		star.center.x = wrapi(star.center.x + 1, 0, viewport_size.x)
		star.center.y = wrapi(star.center.y + 1, 0, viewport_size.y)
		update()


func _create_star():
	rng.randomize()
	var radius = rng.randi_range(1, 3)
	var x = rng.randi_range(0, viewport_size.x)
	var y = rng.randi_range(0, viewport_size.y)
	return {"radius": radius, "center": Vector2(x, y)}
