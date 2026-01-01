extends Node
const GAME_SCENE : String ="res://entities/game/game_scene.tscn"
### Current Upgrade level
var u_food_drop_max :int = 0 # Food drop/s max increase level 
var u_petri_dishes : int = 0 # increase Global multiplier level 
var u_bacteria_speed : int = 0 # Increase Speed of Bacteria level 
var u_bacteria_division_cdr : int = 0# Bacterias will division faster level 
var u_basic_graphs : int  =0 # Line2D  level 
var u_advanced_graphs : int = 0 # Detail with numbers level 
var u_auto_upgrader : int =0 # IF upgrade is possible, auto upgrade  level 

### Current Game Settings
var s_master_volume  : float =0.5
var s_music_volume : float =0.5
var s_sound_volume : float =0.5
var s_fullscreen: int =0
var s_fps_counter : int =1
var s_max_bacterias : int =1000
var s_save_game_data : int =1
var s_save_interval: int =60

### Current Player Progress
var p_dna_currency : float = 0.0
var p_total_bacterias_spawned : float = 1.0
var p_bacterias : float = 1.0
var p_food_slider : float = 0.5
var p_player_archived_game_goal : int =0
var p_bacteria_name : String =""

func reset_game_data() -> void:
    u_food_drop_max = 0
    u_petri_dishes  = 0
    u_bacteria_speed  = 0
    u_bacteria_division_cdr = 0
    u_basic_graphs  =0
    u_advanced_graphs = 0
    u_auto_upgrader =0
    s_master_volume   =0.5
    s_music_volume  =0.5
    s_sound_volume =0.5
    s_fullscreen =0
    s_fps_counter  =1
    s_max_bacterias  =1000
    s_save_game_data  =1
    s_save_interval=60
    p_dna_currency  = 99999999.0
    p_total_bacterias_spawned  = 1.0
    p_bacterias  = 1.0
    p_food_slider  = 0.5
    p_player_archived_game_goal =0
    p_bacteria_name =""

static func num_to_scientific(value: float, decimal_count: int = 3) -> String:
    var is_negative = false
	# handle negative values
    if value < 0:
        value *= -1
        is_negative = true
	
    var exponent: float= 0.0
    var mantissa: float= value

    if value == 0.0:
        return " 0." + "0".repeat(decimal_count) + "e+0  "

    while mantissa < 1.0:
        mantissa *= 10.0
        exponent -= 1
	
    while mantissa > 10.0:
        mantissa /= 10.0
        exponent += 1
	
	# format text
    var mantissa_str = "%.*f" % [decimal_count, mantissa]
    var result = mantissa_str + "e" + "%+-4d" % exponent
    if is_negative:
        result = "-" + result
    else:
        result = " " + result
    return result