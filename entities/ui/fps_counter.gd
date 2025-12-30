extends Label

@export var debug_control : Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if debug_control.visible:
		text = str(int(Engine.get_frames_per_second()))