extends Sprite

var rng = RandomNumberGenerator.new()
const SPAWN_GAP = 50
var velocity_x = 0
var velocity_y = 0
var destroy = false

func _ready():
	rng.randomize()
	
	texture = load(str("res://images/meteor", rng.randi_range(0, 3), ".png"))
	
	var left_spawn = -SPAWN_GAP
	var right_spawn = 600 + SPAWN_GAP
	var top_spawn = -SPAWN_GAP
	var bottom_spawn = 1024 + SPAWN_GAP
	
	var spawn_area_x = rng.randi_range(left_spawn, right_spawn)
	var spawn_area_y = rng.randi_range(top_spawn, bottom_spawn)
	
	var should_spawn_at_x = rng.randi_range(0, 1)
	
	if should_spawn_at_x == 1:
		position.x = spawn_area_x
		position.y = -SPAWN_GAP
		velocity_x = rng.randi_range(-400, 400)
		velocity_y = rng.randi_range(200, 400)
	else:
		position.x = -SPAWN_GAP
		position.y = spawn_area_y
		velocity_x = rng.randi_range(200, 400)
		velocity_y = rng.randi_range(-400, 400)
	
	velocity_x = rng.randi_range(-200, 200)
	velocity_y = rng.randi_range(-200, 200)

func _process(delta):
	position.x = wrapi(position.x + velocity_x * delta, 0, 1024)
	position.y = wrapi(position.y + velocity_y * delta, 0, 600)

