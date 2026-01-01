extends Node

const GAME_SCENE : String ="res://entities/game/game_scene.tscn"

var current_upgrades : Dictionary = {
    "food_drop_max" : 0, # Food drop/s max increase
    "petri_dishes" : 0, # increase Global multiplier
    "bacteria_speed" : 0, # Increase Speed of Bacteria
    "bacteria_division_cdr" : 0,# Bacterias will division faster
    "basic_graphs" : 0, # Line2D
    "advanced_graphs" : 0, # Detail with numbers
    "auto_upgrader" :0 # IF upgrade is possible, auto upgrade
}
var game_settings : Dictionary = {
    "master_volume" : 0.5,
    "music_volume" : 0.5,
    "sound_volume" : 0.5,
    "fullscreen" : 0,
    "fps_counter" : 1,
    "max_bacterias" : 1000,
    "save_game_data" : 1,
    "save_interval" :60
}
var player_progress : Dictionary = {
    "dna_currency" : 0,
    "total_bacterias_spawned" : 1,
    "bacterias" : 1,
    "food_slider" : 0.5,
    "player_archived_game_goal" : 0
}
func reset_game_data() -> void:
    current_upgrades = {
        "food_drop_max" : 0, # Food drop/s max increase
        "petri_dishes" : 0, # increase Global multiplier
        "bacteria_speed" : 0, # Increase Speed of Bacteria
        "bacteria_division_cdr" : 0,# Bacterias will division faster
        "basic_graphs" : 0, # Line2D
        "advanced_graphs" : 0, # Detail with numbers
        "auto_upgrader" :0 # IF upgrade is possible, auto upgrade   
    }
    game_settings = {
        "master_volume" : 0.5,
        "music_volume" : 0.5,
        "sound_volume" : 0.5,
        "fullscreen" : 0,
        "fps_counter" : 1,
        "max_bacterias" : 1000,
        "save_game_data" : 1,
        "save_interval" :60
    }
    player_progress = {
        "dna_currency" : 999999999999999,
        "total_bacterias_spawned" : 1,
        "bacterias" : 1,
        "food_slider" : 0.5,
        "player_archived_game_goal" : 0
}
func increase_dna(_value : float) ->void:
    player_progress["dna_currency"] += _value
