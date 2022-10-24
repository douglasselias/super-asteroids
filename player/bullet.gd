extends Sprite

const speed = 1000
var direction = Vector2.UP
onready var rigid_body = get_node("RigidBody")

func _ready():
	set_as_toplevel(true) # move independent from parent node
	$VisibilityNotifier.connect("screen_exited", self, "_exited_screen")
	$Shot.play()


func _physics_process(delta):
	global_position += direction * speed * delta
	var impulse = (direction * speed * delta).rotated(rotation)
	rigid_body.apply_central_impulse(impulse)


func _exited_screen():
	queue_free()
