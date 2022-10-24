extends RigidBody2D


onready var sprite = $Sprite
onready var rng = RandomNumberGenerator.new()

onready var ExplosionScene = load("res://meteor/Explosion.tscn")

func _ready():
	rng.randomize()
#	sprite.texture = load(str("res://images/meteor", rng.randi_range(0, 3), ".png"))
	$VisibilityNotifier.connect("screen_exited", self, "_exited_screen")
	connect("body_entered", self, "_on_enter")


func _exited_screen():
	queue_free()


func _on_enter(body: Node):
	if "Bullet" in body.name:
		body.queue_free()
		var explosion = ExplosionScene.instance()
		explosion.position = global_position
		get_parent().add_child(explosion)
		var camera = get_node("/root/SceneManager/Camera")
		camera.apply_noise_shake_meteor_explosion()
		var score = get_node("/root/SceneManager/Score/Score")
		score.on_score()
		queue_free()
