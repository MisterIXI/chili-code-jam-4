extends Sprite2D

const SPEED : float = 2.0

var _rotation_angle : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(_event: InputEvent) -> void:
	
	if _event.is_action_pressed("move_backward"):
		_rotation_angle =  -180
	elif _event.is_action_pressed("move_forward"):
		_rotation_angle =  180
	elif _event.is_action_pressed("move_left"):
		_rotation_angle =  90
	elif _event.is_action_pressed("move_right"):
		_rotation_angle = -90
	else:
		if Input.get_vector("move_backward", "move_forward","move_left","move_right").length() < 0.1:
			_rotation_angle = 0

func _process(_delta: float) -> void:

	rotation = _rotation_angle