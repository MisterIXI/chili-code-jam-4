extends Area2D
const TWEEN_DURATION : float = 0.35
var food_amount : int = 1
var _is_allready_eaten : bool = false
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node2D) ->void:
	if _body is Bacteria:
		if !_is_allready_eaten:
			_is_allready_eaten = true

			_body.eat(food_amount)
			# Tween food getting eaten: bouncy scale to 0 then free
			_died()

func _died() ->void:
	#only one time
	var tw = create_tween()
	# Use an elastic/back transition for a bouncy feel
	tw.tween_property(self, "scale", Vector2.ONE * 0.5, TWEEN_DURATION)
	tw.set_trans(Tween.TRANS_ELASTIC)
	tw.set_ease(Tween.EASE_OUT)
	tw.tween_callback(Callable(self, "queue_free"))
	# after tween queue free