extends Sprite

func _process(delta: float) -> void:
	rotate(deg2rad(4 * delta))
