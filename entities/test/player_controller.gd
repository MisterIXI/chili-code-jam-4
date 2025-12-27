extends RigidBody2D

const SPEED: float = 500

var _input_vector : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(_event: InputEvent) -> void:
	_input_vector = Input.get_vector("move_left","move_right", "move_forward", "move_backward")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:

	move_and_collide(_get_velocity(delta))

func _get_velocity(delta : float ) ->Vector2 : 

	var _new_velocity : Vector2 = _input_vector * delta * SPEED

	return _new_velocity
