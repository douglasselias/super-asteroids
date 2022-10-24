extends Node2D

onready var meteor_scene = preload("res://scenes/meteor.tscn")
var rng = RandomNumberGenerator.new()
var max_meteors = 10
var current_count_meteors = 0

func _ready():
	var viewport_size = get_viewport().size
	rng.randomize()
	$Path2D.curve.add_point(Vector2(0, 0))
	$Path2D.curve.add_point(Vector2(viewport_size.x, 0))
	$Path2D.curve.add_point(viewport_size)
	$Path2D.curve.add_point(Vector2(0, viewport_size.y))
	pass
	

func _process(delta: float) -> void:
	if get_child_count() - 2 < max_meteors:
		_create_meteor()
	

func _create_meteor():
	var meteor_node = meteor_scene.instance()
	
	var path2d: PathFollow2D = $Path2D/PathFollow2D
	var r = randf()
	path2d.set_unit_offset(r)
	
	# Set the meteor's direction perpendicular to the path direction.
	var direction = path2d.rotation + PI / 2

	# Set the meteor's position to a random location
	meteor_node.position = path2d.position

	# Add some randomness to the direction
	direction += rng.randf_range(-PI / 4, PI / 4)
	meteor_node.rotation = direction

	# Choose the velocity for the meteor
	var velocity = Vector2(rng.randf_range(150.0, 250.0), 0.0)
	meteor_node.linear_velocity = velocity.rotated(direction)

	# Spawn the meteor by adding it to the Main scene.
	add_child(meteor_node)
