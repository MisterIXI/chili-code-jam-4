extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func effect_start() ->void:
	for x in range(100):
		value = x