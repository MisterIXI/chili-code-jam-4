extends TextureRect
const HOVER_SCALE : Vector2 = Vector2(1.05, 1.05)
const NORMAL_SCALE : Vector2 = Vector2(1, 1)
const PRESSED_SCALE : Vector2 = Vector2(0.96, 0.96)
const TWEEN_DUR : float = 0.12
const HOVER_MODULATE : Color = Color(1.32, 1.32, 1.32, 1)
const NORMAL_MODULATE : Color = Color(1, 1, 1, 1)
var is_bacteria_fokused :bool = false
func _ready() -> void:
	
	mouse_exited.connect(_on_mouse_exited)
	mouse_entered.connect(_on_mouse_entered)
	gui_input.connect(_on_gui_input)
func _on_button_clicked() ->void: 
	print("pressed")

func _on_mouse_entered() -> void:
	_tween_to_scale(HOVER_SCALE, TWEEN_DUR)

func _on_mouse_exited() -> void:
	# restore normal visuals
	_tween_to_scale(NORMAL_SCALE, TWEEN_DUR)

func _on_gui_input(_event: InputEvent) -> void:
	if _event is InputEventMouseButton and (_event.button_index == MOUSE_BUTTON_LEFT or _event.button_index == MOUSE_BUTTON_RIGHT):
		
		if _event.is_pressed():
			# Visual press feedback
			_tween_to_scale(PRESSED_SCALE, 0.06)
			_on_button_clicked()

		else:
			# On release, restore to hover state (mouse_enter will keep it highlighted)
			_tween_to_scale(HOVER_SCALE, TWEEN_DUR)

func _tween_to_scale(target: Vector2, duration: float = TWEEN_DUR) -> void:
	var tw = create_tween()
	tw.tween_property(self, "scale", target, duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	