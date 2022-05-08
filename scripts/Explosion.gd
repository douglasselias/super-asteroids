extends Particles2D

onready var timer = $Timer
onready var boom = $Boom

func _ready():
	one_shot = true
	timer.connect("timeout", self, "_on_timeout")
	boom.play()
	
func _on_timeout():
	queue_free()
