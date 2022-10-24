extends KinematicBody2D

const speed = 1000 * 0.7
var direction = Vector2.UP

func _ready():
	set_as_toplevel(true) # move independent from parent node
	$VisibilityNotifier.connect("screen_exited", self, "_exited_screen")
	$Shot.play()


func _physics_process(delta):
	global_position += direction * speed * delta
#	var impulse = (direction * speed * delta)
#	apply_central_impulse(impulse)


func _exited_screen():
	queue_free()
