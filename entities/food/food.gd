class_name Food
extends Area2D
const TWEEN_DURATION : float = 0.35
var food_amount : int = 1
var _is_already_eaten : bool = false
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	pass

func _on_body_entered(_body: Node2D) ->void:
	if _body is SmartBacteria:
		if !_is_already_eaten:
			_is_already_eaten = true
			# monitorable = false
			# monitoring = false
			# _body.eat(food_amount)
			_body.ate_food()
			# Tween food getting eaten: bouncy scale to 0 then free
			_died()
			#TODO: Death particle
			# queue_free()

func _died() ->void:
	get_child(0).set_deferred("disabled", true)
	#only one time
	var tw = create_tween()
	# Use an elastic/back transition for a bouncy feel
	tw.tween_property(self, "scale", Vector2.ONE * 0.5, TWEEN_DURATION)
	tw.set_trans(Tween.TRANS_ELASTIC)
	tw.set_ease(Tween.EASE_OUT)
	tw.tween_callback(Callable(self, "queue_free"))
	# after tween queue free