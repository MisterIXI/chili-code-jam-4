extends Button


var tween : Tween

func _ready():
	get_material().set_shader_parameter("ripple_origin", Vector2(0,0))
	get_material().set_shader_parameter("ripple_radius", 0.0)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if get_global_rect().has_point(event.position):
			var local_pos = (event.position - global_position) / size
			get_material().set_shader_parameter("ripple_origin", local_pos)
			ripple_effect()

func ripple_effect():
	tween = create_tween()
	tween.tween_method(
		func(value):
			get_material().set_shader_parameter("ripple_radius", float(value) / 50.0),
		0.0,
		150.0,
		1.5
	)
