class_name SmartBacteria
extends RigidBody2D
@onready var sensing: Area2D = $Sensing
@onready var spawn_mgr: Spawn_Manager = Spawn_Manager.singleton
var splitting_cd: float = 0
var move_cd: float = 0
var eaten_food: int = 0
var health: float = 0
var food_in_range: Array[Food]
var target_food: Food

func _ready():
	health = spawn_mgr.start_health
	splitting_cd = spawn_mgr.cooldown

func _physics_process(delta):
	_handle_splitting(delta)
	_handle_movement(delta)
	_handle_hunger(delta)

func _handle_hunger(delta) -> void:
	if eaten_food <= 0 and splitting_cd <= 0:
		health -= delta
		if health <= 0:
			queue_free()

func _handle_movement(delta: float) -> void:
	if target_food and not target_food.is_queued_for_deletion():
		var speed_mult = spawn_mgr.start_speed / 100
		speed_mult = 2
		# turn towards food
		var angle = transform.x.angle_to(target_food.global_position - global_position)
		# monkey lerp the angular velocity towards target with 2Pi per second (PI == 180 deg per second)
		angular_velocity = move_toward(angular_velocity, angle * 2, PI * 2.0 * delta * speed_mult)
		# speed boost forward
		move_cd -= delta
		if move_cd <= 0:
			move_cd = 1.0 / speed_mult
			linear_velocity -= transform.y.dot(linear_velocity) / 2.0 * transform.y
			apply_impulse(transform.x * (25* speed_mult))
			

func _handle_splitting(delta: float) -> void:
	splitting_cd = max(splitting_cd - delta, 0)
	if splitting_cd <= 0 and eaten_food > 0:
		# print("split: ", splitting_cd, "  food: ", eaten_food)
		# split into two cells
		spawn_mgr.spawn(global_position)
		splitting_cd = spawn_mgr.cooldown
		eaten_food -= 1

func find_closest_food():
	if food_in_range.size() <= 0:
		# if no food is in range, set target to null and exit
		target_food = null
		return
	var curr_closest: float
	curr_closest = food_in_range[0].global_position.distance_squared_to(global_position)
	target_food = food_in_range[0]
	for food in food_in_range:
		var dist_to_food = food.global_position.distance_squared_to(global_position)
		if dist_to_food < curr_closest:
			curr_closest = dist_to_food
			target_food = food

func _on_sensing_area_entered(area: Area2D) -> void:
	if area is Food:
		food_in_range.append(area)
		find_closest_food()

func _on_sensing_area_exited(area: Area2D) -> void:
	if area is Food:
		var index = food_in_range.find(area)
		if index == -1:
			push_error("index OOB on food area exit")
		food_in_range.remove_at(index)
		find_closest_food()

func ate_food() -> void:
	eaten_food += 1
	if eaten_food > spawn_mgr.max_food_eaten:
		# initiate death
		queue_free()
	target_food = null
