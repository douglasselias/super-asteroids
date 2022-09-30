extends CenterContainer

var final_score = 0

func _process(_delta):
	$Score.text = "Score: %d" % final_score

func reset_score():
	final_score = 0

func play_sfx():
	$Lose.play()
