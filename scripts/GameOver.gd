extends CenterContainer

var final_score = 0

func _process(delta):
	$Score.text = "Score: " + str(final_score)

func reset_score():
	final_score = 0

func play_sfx():
	$Lose.play()
