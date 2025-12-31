extends MarginContainer
const STRING_LEVEL : String = "Level: "
const STRING_COST : String = "Cost: "

@onready var upgrade_texture : TextureRect = $PanelContainer/HBoxContainer/MarginContainer/TextureRect
@onready var upgrade_name : Label =  $PanelContainer/HBoxContainer/VBoxContainer/upgrade_name
@onready var upgrade_level : Label = $PanelContainer/HBoxContainer/VBoxContainer/Level_value
@onready var upgrade_effect_value : Label = $PanelContainer/HBoxContainer/VBoxContainer/effect_value
@onready var upgrade_cost : Label = $PanelContainer/HBoxContainer/VBoxContainer/HBoxContainer/upgrade_cost
## tooltip
@onready var upgrade_tooltip : PanelContainer =$PanelContainer
#### Get data: 
@export var upgrade_string : String ="Test_Upgrade"
## important must be string and contains hotkey_
@export var hotkey : String="hotkey_1"
@export var is_one_time_upgrade :bool = false
#private variables 
var is_enabled : bool = true

const HOVER_SCALE : Vector2 = Vector2(1.05, 1.05)
const NORMAL_SCALE : Vector2 = Vector2(1, 1)
const PRESSED_SCALE : Vector2 = Vector2(0.96, 0.96)
const TWEEN_DUR : float = 0.12
const HOVER_MODULATE : Color = Color(1.06, 1.06, 1.06, 1)
const NORMAL_MODULATE : Color = Color(1, 1, 1, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpgradeManager.update_visual_upgrade.connect(_on_upgrade_leveled)
	UpgradeManager.upgrade_reached_max.connect(_on_upgrade_reached_max)

func _set_data(_upgrade : Upgrade) ->void:
	upgrade_level.text = str(_upgrade.upgrade_level)
	upgrade_effect_value.text = str(_upgrade.get_effect_value_text())
	upgrade_cost.text = str(_upgrade.upgrade_cost)
	upgrade_texture.texture = _upgrade.upgrade_texture
	upgrade_name.text = _upgrade.upgrade_name
	upgrade_tooltip.tooltip_text = _upgrade.upgrade_description

func _on_upgrade_reached_max(_upgrade : Upgrade) ->void:
	if upgrade_string == _upgrade.upgrade_name:
		### HIDE ONE TIME UPGRADES
		if is_one_time_upgrade:
			hide()
		else:
			## SOLD OUT EFFECT AND NO HOVER HIGHLIGHT
			upgrade_level.text = str(_upgrade.upgrade_level)
			upgrade_effect_value.text = str(_upgrade.get_effect_value_text())
			upgrade_cost.text = "Sold Out"
			upgrade_texture.texture = _upgrade.upgrade_texture
			upgrade_name.text = _upgrade.upgrade_name
			upgrade_tooltip.tooltip_text = _upgrade.upgrade_description + " You reached max level."
			is_enabled = false

func _on_upgrade_leveled(_upgrade: Upgrade) ->void:
	if upgrade_string == _upgrade.upgrade_name:
		_set_data(_upgrade)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed(hotkey):
		print("Pressed")
		# Visual press feedback
		_tween_to_scale(PRESSED_SCALE, 0.06)
		# Trigger upgrade action
		UpgradeManager.on_upgrade_clicked(upgrade_string)
	if Input.is_action_just_released(hotkey):
		print("release")
		#On release, restore to hover state (mouse_enter will keep it highlighted)
		_tween_to_scale(HOVER_SCALE, TWEEN_DUR)

func _on_gui_input(_event: InputEvent) -> void:
	if _event is InputEventMouseButton and (_event.button_index == MOUSE_BUTTON_LEFT or _event.button_index == MOUSE_BUTTON_RIGHT):
		if _event.is_pressed():
			print("Pressed")
			# Visual press feedback
			_tween_to_scale(PRESSED_SCALE, 0.06)
			# Trigger upgrade action
			UpgradeManager.on_upgrade_clicked(upgrade_string)
		else:
			print("release")
			# On release, restore to hover state (mouse_enter will keep it highlighted)
			_tween_to_scale(HOVER_SCALE, TWEEN_DUR)

func _on_mouse_exited() -> void:
	print("mover exit")
	# restore normal visuals
	if not is_enabled:
		return
	modulate = NORMAL_MODULATE
	_tween_to_scale(NORMAL_SCALE, TWEEN_DUR)

func _on_mouse_entered() -> void:
	print("mouse entered")
	if not is_enabled:
		return
	# slight brighten + grow
	modulate = HOVER_MODULATE
	_tween_to_scale(HOVER_SCALE, TWEEN_DUR)


func _tween_to_scale(target: Vector2, duration: float = TWEEN_DUR) -> void:
	var tw = create_tween()
	tw.tween_property(self, "scale", target, duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	