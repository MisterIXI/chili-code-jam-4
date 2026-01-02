extends Node2D
class_name Spawn_Manager
signal food_rotted(_value : int)
signal spawn_tick
const FOOD_SCENE = preload("res://entities/food/food.tscn")
const SMART_BACTERIA_SCENE = preload("res://entities/bacteria/smart_bacteria.tscn")
const SPAWN_RADIUS = 700
@export var real_spawn_curve: Curve
@export var food_mgr: FoodManager
var start_health : int = 10
var bacteria_speed  : float = 100
var cooldown : float = 2.0
var max_food_eaten: int = 5
var fake_bacteria_count: float
var current_spawn_cap: float = 10_000
var spawn_tracker_cd: float = 0.5
const SPAWN_TICK_CD: float = 0.5
var spawn_stat_arr: Array[float] = []
var avg_spawn_rate: float = 0
var spawn_accum: float = 0
static var singleton

var fake_food_count: float = 0
var food_root: Node2D

var no_bacteria_countdown: float = 0.0

func _init():
	singleton = self
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	food_root = Node2D.new()
	food_root.name = "FoodRoot"
	add_sibling.call_deferred(food_root)
	# _new_bacteria(start_health * 10,bacteria_speed*2,  global_position)
	UpgradeManager.update_visual_upgrade.connect(_on_update_visual_upgrade)
	_spawn_bacteria(Vector2(randf() * 50, randf() * 50), randf() * 2 * PI, Vector2(randf() * 30, randf() * 30))

func _physics_process(delta):
	spawn_tracker_cd -= delta
	if spawn_tracker_cd <= 0:
		spawn_tracker_cd = SPAWN_TICK_CD
		var real_bac_count = get_child_count()
		var real_mult = real_spawn_curve.sample(real_bac_count / float(GameData.s_max_bacterias))
		handle_bacteria_spawn(real_bac_count, real_mult)
		handle_food_spawn()
		GameData.p_bacterias = real_bac_count + fake_bacteria_count
		print("Bact_real: ", real_bac_count, " Bact_fake: ", fake_bacteria_count, " real_food: ", food_root.get_child_count(), " fake_food: ", fake_food_count)
		spawn_tick.emit()
		if real_bac_count + fake_bacteria_count == 0.0 and no_bacteria_countdown < 0.0:
			no_bacteria_countdown = 3.0
		no_bacteria_countdown = max(0.0, no_bacteria_countdown - SPAWN_TICK_CD)
		if real_bac_count + fake_bacteria_count == 0.0 and no_bacteria_countdown == 0.0:
			_spawn_bacteria(Vector2(randf() * 50, randf() * 50), randf() * 2 * PI, Vector2(randf() * 30, randf() * 30))

func handle_food_spawn() -> void:
	var count = calc_food_rate() * SPAWN_TICK_CD
	if count == 0.0:
		print("No food to spawn")
		return
	# count = max(1.0, count)
	var real_food_count = food_root.get_child_count()
	var real_mult = real_spawn_curve.sample(real_food_count / float(GameData.s_max_bacterias) / cooldown)
	var real_spawns = count * real_mult
	var overflow = real_spawns - clampf(real_spawns, 0, GameData.s_max_bacterias - real_food_count)
	real_spawns = max(real_spawns - overflow, 0)
	var fake_spawns = count - real_spawns
	fake_food_count += fake_spawns
	if real_spawns < 1.0 and real_spawns > 0.0:
		if randf() < real_spawns:
			real_spawns = 1.0
		else:
			real_spawns = 0.0
			return
	spread_calls(_spawn_food,real_spawns)
	# for i in range(real_spawns):
	# 	_spawn_food()

func handle_bacteria_spawn(real_bac_count: float, real_mult: float) -> void:
	spawn_stat_arr.append(spawn_accum)
	spawn_accum = 0.0
	if spawn_stat_arr.size() == 1:
		return
	if spawn_stat_arr.size() > 10:
		spawn_stat_arr.pop_front()
	var rate_acc: float = 0
	for i in range(spawn_stat_arr.size() - 1):
		rate_acc += spawn_stat_arr[i + 1] - spawn_stat_arr[i]
	avg_spawn_rate = rate_acc / (spawn_stat_arr.size() - 1)

	var needed_food = fake_bacteria_count / cooldown
	# handle hunger of fake bacterias
	var hungry_fakes = max(needed_food - fake_food_count, 0.0)
	if hungry_fakes > 0.0:
		# round up to 1
		hungry_fakes = max(hungry_fakes, 1.0)
	fake_bacteria_count = max(0.0, fake_bacteria_count - hungry_fakes)
	#TODO: Track death
	fake_food_count = max(0.0, fake_bacteria_count - needed_food)
	if fake_food_count >= 1.0:
		var rotten_food = fake_food_count * 0.1
		fake_food_count =- rotten_food
		food_rotted.emit(rotten_food)
		
		fake_bacteria_count = max(0.0, fake_bacteria_count - rotten_food)
		#TODO: Track death

	# handle too much
	#print("Bacteria (r/f): (", real_bac_count, "/", fake_bacteria_count,")\nAvg rate: ", avg_spawn_rate, "\nFake Mult: ", fake_mult , "\nFake Kill: ", fake_kill)
	var bacterias_to_spawn: float = (fake_bacteria_count - needed_food) / cooldown
	if bacterias_to_spawn >= 1.0:
		fake_spawn(bacterias_to_spawn, real_mult)

func get_current_bacterias_count() -> float:
	return get_child_count() + fake_bacteria_count

func fake_spawn(count: float, real_mult: float) -> void:
	assert(not is_nan(count))
	var bac_count = get_current_bacterias_count()
	count = min(calc_spawn_cap() - bac_count, count)
	var real_spawn_count: int = floor(count * real_mult)
	fake_bacteria_count += count * (1.0 - real_mult)
	spread_calls(func():_spawn_bacteria((Vector2.RIGHT * randf() * SPAWN_RADIUS).rotated(randf() * PI * 2), randf() * 2 * PI), real_spawn_count)
	spawn_accum += real_spawn_count
	_add_player_progress(floor(count))

func instant_spawn(source_bacteria: SmartBacteria) ->void:
	var real_bac_count = get_child_count()
	if real_bac_count + fake_bacteria_count + 1 >= calc_spawn_cap() :
		# cancel spawn when this would exceed spawn cap
		return
	var is_real_spawn: bool = randf() < real_spawn_curve.sample(float(real_bac_count) / GameData.s_max_bacterias)
	if is_real_spawn:
		_spawn_bacteria(source_bacteria.global_position, -source_bacteria.rotation, -source_bacteria.linear_velocity / 2.0)
		spawn_accum += 1
	else:
		fake_bacteria_count += 1.0
	_add_player_progress(1)	

func _spawn_bacteria(pos: Vector2, rotation: float = 0.0, velocity: Vector2 = Vector2.ZERO) -> void:
	var bacteria: SmartBacteria = SMART_BACTERIA_SCENE.instantiate()
	add_child(bacteria)
	bacteria.global_position = pos
	bacteria.linear_velocity = velocity
	bacteria.rotation = rotation
	bacteria.health = start_health
	# SoundManager.play_division_sound()

func _spawn_food() -> void:
	var food_pos: Vector2 = (Vector2.RIGHT * randf() * SPAWN_RADIUS).rotated(randf() * PI * 2)
	# instant query to avoid actual spawning on top of bacteria
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = 30
	var  query = PhysicsShapeQueryParameters2D.new()
	query.shape_rid = circle_shape.get_rid()
	query.transform = Transform2D(0, food_pos)
	query.collision_mask = 1

	var space = get_world_2d().direct_space_state
	var results = space.intersect_shape(query)
	var bacts = []
	for result in results:
		var collider = result["collider"]
		if collider is SmartBacteria:
			bacts.append(collider)
	if bacts.size() > 0:
		bacts.pick_random().ate_food()
	else:
		# actually spawn
		var food: Food = FOOD_SCENE.instantiate()
		food_root.add_child(food)
		food.global_position = food_pos

func _add_player_progress(_count :int) ->void:
	## add bacterias to stats
	for x in range(_count):
		GameData.p_total_bacterias_spawned +=1
		GameData.p_dna_currency += GameData.get_all_upgrade_levels()

func calc_food_rate() -> float:
	return GameData.p_food_slider * (exp(0.35 * (GameData.u_food_drop_max + 1)))

func get_current_foods() -> float:
	if not food_root:
		return 0.0
	return fake_food_count + food_root.get_child_count()
func calc_spawn_cap() -> float:
	return exp(0.35 * (GameData.u_petri_dishes)) * 1000

func _on_update_visual_upgrade(_upgrade) -> void:
	bacteria_speed = 100 + 20 * (GameData.u_bacteria_speed) 
	cooldown = -0.075 * GameData.u_bacteria_division_cdr + 2

func spread_calls(fun: Callable, count: int, max_frames = 10):
	@warning_ignore("INTEGER_DIVISION")
	var calls_per_frame = count / (max_frames - 1)
	var remaining = count % (max_frames - 1)
	print("count: ", count, " per_frame: ", calls_per_frame, " remaining: ", remaining)
	for i in range(max_frames - 1):
		for j in range(calls_per_frame):
			fun.call()
		await get_tree().process_frame
	for j in range(remaining):
		fun.call()
