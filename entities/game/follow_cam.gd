class_name FollowCam
extends Camera2D
@onready var spawn_mgr: Spawn_Manager = Spawn_Manager.singleton
var target: Node2D = null
var is_following: bool = false
var zoom_tweener: Tween
var close_bacterias: Array[SmartBacteria] = []


func toggle_follow() -> void:
	is_following = not is_following
	if not is_following:
		global_position = Vector2.ZERO
		zoom_to_tweener(Vector2.ONE * 0.345)
	else:
		zoom_to_tweener(Vector2.ONE * 0.8)

func _process(_delta):
	if not is_following:
		return
	if target:
		global_position = target.global_position
	else:
		target = close_bacterias.reduce(
			func(accum, x):
				if global_position.distance_squared_to(x.global_position) < global_position.distance_squared_to(accum.global_position):
					return x
				else:
					return accum)
		if not target and spawn_mgr.get_child_count() > 0:
			target = spawn_mgr.get_child(0)
func zoom_to_tweener(target_zoom: Vector2) -> void:
	if zoom_tweener:
		zoom_tweener.kill()
	zoom_tweener = create_tween()
	zoom_tweener.tween_property(self, "zoom", target_zoom, 0.5)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is SmartBacteria:
		close_bacterias.append(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is SmartBacteria:
		var index = close_bacterias.find(body)
		if index != -1:
			close_bacterias.remove_at(index)
