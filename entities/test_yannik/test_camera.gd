extends Camera2D

@onready var spawn_mgr: Spawn_Manager = Spawn_Manager.singleton

var target: Node2D

func _physics_process(delta):
	if not target or target.is_queued_for_deletion() and spawn_mgr.get_child_count() > 0:
		target = spawn_mgr.get_child(0)
	if target:
		global_position = target.global_position
