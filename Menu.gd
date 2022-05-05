extends CenterContainer

enum SELECTED { START, CONTROLS }
var current_selected = SELECTED.START
onready var Start = $Start as Label
onready var Controls = $Controls as Label
const green = Color(0.1, 0.7, 0.5, 1)
onready var Click = $Click

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		current_selected = SELECTED.START
		Click.play()
	if Input.is_action_just_pressed("ui_down"):
		current_selected = SELECTED.CONTROLS
		Click.play()
	
	Start.modulate = Color.white
	Controls.modulate = Color.white
	
	match (current_selected):
		SELECTED.START:
			Start.modulate = green
		SELECTED.CONTROLS:
			Controls.modulate = green
