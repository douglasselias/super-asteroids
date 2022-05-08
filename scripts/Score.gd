extends Label

var score = 0

func _ready():
	margin_left = 140
	margin_top = 20
	
func _process(delta):
	text = "Score: " + str(score)

