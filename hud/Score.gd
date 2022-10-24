extends Label

var score = 0

func _ready():
	get_parent().position = Vector2(140, 20)
	_update_text()


func on_score():
	score += 100
	_update_text()


func on_reset():
	score = 0
	_update_text()


func _update_text():
	text = "Score %d" % score
