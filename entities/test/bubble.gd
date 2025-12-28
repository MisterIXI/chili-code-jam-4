extends RigidBody2D
class_name Bacteria
var life_time : float = 10.0
var well_fed : int = 0

# Called when the node instantiate
func setup(_life_time : float, _speed : float) -> void:
	linear_velocity = Vector2(_speed,_speed)
	life_time = _life_time

func _physics_process(delta: float) -> void:
	life_time -= delta
	_check_death()

func _check_death() -> void:
	if life_time <= 0:
		_died()
	
func _died() ->void:
	# wait 1 seconds and animation

	#chance to drop food if die after ugprade is enabled
	print("bacteria died")
	queue_free()

func eat(_amount : int) ->void:
	well_fed += _amount
	print("eat")
	cellula_divisio()

func cellula_divisio() ->void:
	#Spawn Manager with Timer give position
	get_parent().spawn(well_fed,global_position)
	#well_fed = 0