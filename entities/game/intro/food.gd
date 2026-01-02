extends AnimatedSprite2D

@onready var _timer :Timer =$Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() ->void:
	_timer.wait_time = randf_range(5,30)
	scale = Vector2(randf_range(0.9,1.5), randf_range(0.9,1.5))