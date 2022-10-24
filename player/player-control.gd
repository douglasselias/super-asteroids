extends RigidBody2D

signal hitted

onready var bullet_scene = preload("res://player/bullet/bullet.tscn")

const rotation_speed = 100

onready var parent = get_parent()
onready var viewport_size = get_viewport().size
onready var booster_sfx = $Booster
onready var fire_fx = $Fire
onready var collision = $Collision


func _ready():
	parent.position = viewport_size / 2
	connect("body_entered", self, "_on_enter")


func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		var bullet_node = bullet_scene.instance()
		bullet_node.global_position = global_position + Vector2(0, -18).rotated(rotation)
		bullet_node.direction = Vector2.UP .rotated(rotation)
		bullet_node.rotation = rotation
		add_child(bullet_node)


func _physics_process(_delta):
	if Input.is_action_pressed("ui_left"):
		apply_torque_impulse(-rotation_speed)

	if Input.is_action_pressed("ui_right"):
		apply_torque_impulse(rotation_speed)

	if Input.is_action_pressed("ui_up"):
		var impulse = (Vector2.UP * 10).rotated(rotation)
		apply_central_impulse(impulse)
		
		fire_fx.visible = true

		if not booster_sfx.playing:
			booster_sfx.play()
	else:
		booster_sfx.stop()
		fire_fx.visible = false


func _integrate_forces(state: Physics2DDirectBodyState):
	state.transform.origin = _wrapv(state.transform.origin, Vector2.ZERO, viewport_size)


func _wrapv(value: Vector2, minv: Vector2, maxv: Vector2) -> Vector2:
	value.x = wrapf(value.x, minv.x, maxv.x)
	value.y = wrapf(value.y, minv.y, maxv.y)
	return value


func _on_enter(body: Node):
	if "Meteor" in body.name:
		$Hurt.play()
		Engine.time_scale = 0.05
		yield(get_tree().create_timer(0.05, false), "timeout")
		Engine.time_scale = 1
		emit_signal("hitted")

