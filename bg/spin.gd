extends Sprite

onready var noise: Sprite = $"NoiseGas"

func _process(delta: float):
	noise.rotate(delta * 0.1)
