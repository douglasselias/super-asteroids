extends Sprite

const speed = 10
onready var VisibilityNode = VisibilityNotifier2D.new()
onready var ColliderNode = $Collider

func _ready():
	visible = false
	ColliderNode.connect("body_entered", self, "_on_body_entered")
	VisibilityNode.connect("screen_exited", self, "_on_exit")
	add_child(VisibilityNode)

func _process(delta):
	if visible:
		var padded_rotation = rotation + deg2rad(-90)
		position.x = position.x + cos(padded_rotation) * speed
		position.y = position.y + sin(padded_rotation) * speed

func play_sfx():
	$Shot.play()
	
func _on_exit():
	visible = false

func _on_body_entered(node: Node):
	if visible and "Meteor" in node.owner.name:
		node.owner.destroy = true
		visible = false
		get_node("/root/Main/Score2D/Score").score += 100
		get_node("/root/Main/GameOver").final_score += 100
