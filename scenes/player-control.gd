extends RigidBody2D

var speed = 0
var v = Vector2.ZERO
var rotation_dir = 0

func _ready() -> void:
	position = get_viewport().size / 2

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		print("Engine on")
#		add_central_force(Vector2.UP)
#		apply_central_impulse(Vector2(speed, 0))
		add_central_force(v.rotated(rotation))
		apply_torque_impulse(rotation_dir * 2)
		pass
	else:
		v = Vector2.ZERO
	
	if Input.is_action_pressed("ui_left"):
		print("Rotate left")
		rotation_dir += 1
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1

