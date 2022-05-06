extends Sprite

const rotation_speed = 10
const boost = 10
const friction = 0.1
var speed = 0

onready var BoosterNode = $Booster
onready var FireNode = $Fire

func _ready():
	position.x = 1024 / 2
	position.y = 600 / 2

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		rotation -= rotation_speed * delta

	if Input.is_action_pressed("ui_right"):
		rotation += rotation_speed * delta

	if Input.is_action_pressed("ui_up"):
		speed += boost * delta
		
	var padded_rotation = rotation + deg2rad(-90)
		
	position.x = wrapf((position.x + cos(padded_rotation) * speed), 0, 1024)
	position.y = wrapf((position.y + sin(padded_rotation) * speed), 0, 600)
	
	speed = max(0, speed - friction)
	
	if speed > 0:
		FireNode.emitting = true
		yield(get_tree().create_timer(0.5), "timeout")
		if not BoosterNode.is_playing():
			BoosterNode.play()

	if speed < 2:
		FireNode.emitting = false
		yield(get_tree().create_timer(0.5), "timeout")
		BoosterNode.stop()
