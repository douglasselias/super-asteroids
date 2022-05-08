extends Sprite

const rotation_speed = 10
const boost = 10
const friction = 0.1
var speed = 0

onready var BoosterNode = $Booster
onready var FireNode = $Fire
onready var ColliderNode = $Collider
onready var HurtNode = $Hurt
onready var BulletScene = load("res://scenes/Bullet.tscn")
onready var BulletNode = BulletScene.instance()

signal hit

func _ready():
	ColliderNode.connect("body_entered", self, "_on_body_entered")
	position.x = 1024 / 2
	position.y = 600 / 2
	add_child(BulletNode)
	BulletNode.set_as_toplevel(true)

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		rotation -= rotation_speed * delta

	if Input.is_action_pressed("ui_right"):
		rotation += rotation_speed * delta

	if Input.is_action_pressed("ui_up"):
		speed += boost * delta
	
	if not BulletNode.visible:
		BulletNode.position = position
		BulletNode.rotation = rotation

	if Input.is_action_just_pressed("ui_accept"):
		if not BulletNode.visible:
			BulletNode.visible = true
			BulletNode.play_sfx()
		
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
		
func _on_body_entered(node: Node):
	if "Meteor" in node.owner.name:
		node.owner.destroy = true
		HurtNode.play()
		emit_signal("hit")
		
