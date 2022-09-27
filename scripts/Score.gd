extends Label

var score = 0

func _ready():
	margin_left = 140
	margin_top = 20
	connect("update_score", self, "_on_score")
	
func _process(_delta):
	text = "Score: " + str(score)

func _on_score():
	score += 100
	pass
