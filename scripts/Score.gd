extends Label

class_name Score

var score = 0


func _ready():
	text = "Score %d" % score
	get_parent().position = Vector2(140, 20)
#	connect("update_score", self, "_on_score")


func _process(_delta):
#	text = "Score: " + score
	pass


func on_score():
	score += 100
	text = "Score %d" % score
