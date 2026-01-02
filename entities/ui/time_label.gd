extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	text = _calculate_time_string()

func _calculate_time_string() -> String:
	@warning_ignore("integer_division")
	var _time: int = (Time.get_ticks_msec() - GameUi.start_game_time) / 1000
	@warning_ignore("integer_division")
	var minutes = fmod(_time / 60, 60)
	var seconds = fmod(_time, 60)
	return "Time: %02d:%02d" % [minutes, seconds]
