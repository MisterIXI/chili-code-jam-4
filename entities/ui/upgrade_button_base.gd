extends MarginContainer
const STRING_LEVEL : String = "Level: "
const STRING_COST : String = "Cost: "

@onready var upgrade_texture : TextureRect = $PanelContainer/HBoxContainer/MarginContainer/TextureRect
@onready var upgrade_name : Label =  $PanelContainer/HBoxContainer/VBoxContainer/upgrade_name
@onready var upgrade_level : Label = $PanelContainer/HBoxContainer/VBoxContainer/Level_value
@onready var upgrade_effect_value : Label = $PanelContainer/HBoxContainer/VBoxContainer/effect_value
@onready var upgrade_cost : Label = $PanelContainer/HBoxContainer/VBoxContainer/HBoxContainer/upgrade_cost
## tooltip
@onready var upgrade_tooltip_panel : PanelContainer =$PanelContainer
#### Get data: 
@export var upgrade_string : String ="Test_Upgrade"
## important must be string and contains hotkey_
@export var hotkey : String="hotkey_1"
@export var is_one_time_upgrade :bool = false
#private variables 
var is_enabled : bool = true
var _current_upgrade_costs : int = 0
const HOVER_SCALE : Vector2 = Vector2(1.05, 1.05)
const NORMAL_SCALE : Vector2 = Vector2(1, 1)
const PRESSED_SCALE : Vector2 = Vector2(0.96, 0.96)
const TWEEN_DUR : float = 0.12
const HOVER_MODULATE : Color = Color(1.32, 1.32, 1.32, 1)
const NORMAL_MODULATE : Color = Color(1, 1, 1, 1)

const DISABLED_MODULATE : Color = Color(1,1,1,0.3)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpgradeManager.update_visual_upgrade.connect(_on_upgrade_leveled)
	UpgradeManager.upgrade_reached_max.connect(_on_upgrade_reached_max)
	_initialize_data()

#### UPDATE BUYABLE STATE
func _physics_process(_delta: float) -> void:
	if _current_upgrade_costs > GameData.p_dna_currency:
		if is_enabled:
			is_enabled = false
			upgrade_tooltip_panel.modulate = DISABLED_MODULATE
	else:
		if !is_enabled:
			is_enabled =true
			upgrade_tooltip_panel.modulate = NORMAL_MODULATE

### initialize Upgrade Visuals
func _initialize_data() ->void :
	for x in UpgradeManager.upgrade_list:
		if upgrade_string == x.upgrade_name:
			_set_data(x)
			## One time init
			upgrade_texture.texture = x.upgrade_texture
			upgrade_name.text = x.upgrade_name
			upgrade_tooltip_panel.tooltip_text = x.upgrade_description


func _set_data(_upgrade : Upgrade) ->void:
	upgrade_level.text = "Level: " + str(_upgrade.upgrade_level)
	upgrade_effect_value.text = _upgrade.get_effect_value_text()
	upgrade_cost.text = "Costs: " + str(_upgrade.upgrade_cost)
	# SET  current upgrade costs 
	_current_upgrade_costs = _upgrade.upgrade_cost

func _on_upgrade_reached_max(_upgrade : Upgrade) ->void:
	if upgrade_string == _upgrade.upgrade_name:
		## SOLD OUT EFFECT AND NO HOVER HIGHLIGHT
		upgrade_level.text = "MAX"
		upgrade_effect_value.text = str(_upgrade.get_effect_value_text())
		upgrade_cost.text = "Sold Out"
		upgrade_texture.texture = _upgrade.upgrade_texture
		upgrade_name.text = _upgrade.upgrade_name
		upgrade_tooltip_panel.tooltip_text = _upgrade.upgrade_description + " You reached max level."
		is_enabled = false

func _on_upgrade_leveled(_upgrade: Upgrade) ->void:
	if upgrade_string == _upgrade.upgrade_name:
		_set_data(_upgrade)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(hotkey):

		# Visual press feedback
		if is_enabled:
			_tween_to_scale(PRESSED_SCALE, 0.06)
			# Trigger upgrade action
			UpgradeManager.on_upgrade_clicked(upgrade_string)
		else:
			SoundManager.play_error()
	if Input.is_action_just_released(hotkey):
		if is_enabled:
			#On release, restore to hover state (mouse_enter will keep it highlighted)
			_tween_to_scale(NORMAL_SCALE, TWEEN_DUR)

func _on_gui_input(_event: InputEvent) -> void:
	if _event is InputEventMouseButton and (_event.button_index == MOUSE_BUTTON_LEFT or _event.button_index == MOUSE_BUTTON_RIGHT):
		if is_enabled:
			if _event.is_pressed():
				# Visual press feedback
				_tween_to_scale(PRESSED_SCALE, 0.06)
				# Trigger upgrade action
				UpgradeManager.on_upgrade_clicked(upgrade_string)
					
			else:
				# On release, restore to hover state (mouse_enter will keep it highlighted)
				_tween_to_scale(HOVER_SCALE, TWEEN_DUR)
		else:
			if _event.is_pressed():
				SoundManager.play_error()

func _on_mouse_exited() -> void:
	# restore normal visuals
	if not is_enabled:
		return
	upgrade_tooltip_panel.modulate = NORMAL_MODULATE
	_tween_to_scale(NORMAL_SCALE, TWEEN_DUR)

func _on_mouse_entered() -> void:
	if not is_enabled:
		return
	# slight brighten + grow
	upgrade_tooltip_panel.modulate = HOVER_MODULATE
	_tween_to_scale(HOVER_SCALE, TWEEN_DUR)

func _tween_to_scale(target: Vector2, duration: float = TWEEN_DUR) -> void:
	var tw = create_tween()
	tw.tween_property(self, "scale", target, duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	