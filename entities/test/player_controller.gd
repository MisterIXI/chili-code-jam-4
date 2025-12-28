extends RigidBody2D

const SPEED: float = 500.0
const ACCELERATION : float = 1110.0

var _input_vector : Vector2 = Vector2.ZERO
var _old_velocity : Vector2  = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(_event: InputEvent) -> void:
	_input_vector = Input.get_vector("move_left","move_right", "move_forward", "move_backward")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	
	#_old_velocity = linear_velocity
	
	linear_velocity = _get_velocity(_delta)


func _get_velocity(_delta: float) ->Vector2 : 
	var _new_velocity : Vector2 = _input_vector * SPEED

	var _result : Vector2 = _old_velocity.move_toward(_new_velocity,ACCELERATION * _delta)
	_old_velocity = _result
	return _result
	#return linear_velocity.move_toward(_new_velocity, ACCELERATION * _delta)
