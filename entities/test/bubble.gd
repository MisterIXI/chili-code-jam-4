extends RigidBody2D
class_name Bacteria
var life_time : float = 100.0
var well_fed : int = 0

@onready var anim_sprite :AnimatedSprite2D =$AnimatedSprite2D
func _ready() -> void:
	anim_sprite.animation_finished.connect(_on_animation_finished_dying)
# Called when the node instantiate
func setup(_life_time : float, _speed : float) -> void:
	linear_velocity = Vector2(_speed,_speed)
	life_time = _life_time
	print("setup complete")

func _physics_process(delta: float) -> void:
	life_time -= delta
	_check_death()

func _check_death() -> void:
	if life_time <= 0:
		_died()
	
func _died() ->void:

	anim_sprite.play("dying")
	linear_damp = 0.9

func eat(_amount : int) ->void:
	well_fed += _amount
	cellula_divisio()

func cellula_divisio() ->void:
	#Spawn Manager with Timer give position

	get_parent().spawn(global_position)
	well_fed = 0

func _on_animation_finished_dying() ->void:
	if anim_sprite.animation == "dying":
		print("bacteria died")
		#chance to drop food if die after ugprade is enabled
		queue_free()