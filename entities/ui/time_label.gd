extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:

	text = _calculate_time_string()

func _calculate_time_string() ->String:

	var _time : int = Time.get_ticks_msec() - GameUi.start_game_time
	var minutes = _time / 60
	var seconds = fmod(_time, 60)
	var milliseconds = fmod(_time, 1) * 100
	return "Time: %02d:%02d:%02d" % [minutes, seconds, milliseconds]
	