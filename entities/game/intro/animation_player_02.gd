extends AnimationPlayer
@export var animation_string : String = "test"
@onready var _timer :Timer =$Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout()->void:
	play(animation_string)



func _on_animation_finished(_anim_name: StringName) -> void:
	_timer.wait_time = randf_range(5,25)
	speed_scale = randf_range(1,4)
	_timer.start()

