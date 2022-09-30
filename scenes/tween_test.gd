extends RichTextLabel

const tween_speed = 0.5
var tween: SceneTreeTween

func _ready():
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_loops()
	tween.tween_property(self, "modulate", Color.transparent, tween_speed)
	tween.tween_property(self, "modulate", Color.white, tween_speed)
	stop_tween()

func start_tween():
	tween.play()

func stop_tween():
	tween.stop()
