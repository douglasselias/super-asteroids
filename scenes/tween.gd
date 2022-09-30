extends RichTextLabel

const tween_speed = 0.5
var tween: SceneTreeTween


func _ready():
	create_blink_tween()


func create_blink_tween():
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_loops()
	tween.tween_property(self, "modulate", Color.transparent, tween_speed)
	tween.tween_property(self, "modulate", Color.white, tween_speed)
	tween.stop()


func start_tween():
	if tween == null:
		create_blink_tween()
	
	tween.play()


func stop_tween():
	tween.kill()
	tween = null
