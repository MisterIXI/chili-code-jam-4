extends Node

const GAME_SCENE : String ="res://entities/game/game_scene.tscn"

var current_upgrades : Dictionary = {
    "upgrade_food_dense" : 0
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
    "bacterias" : 1,
    "petri_dishes" : 0,
    "player_archived_game_goal" : 0,
    "epic_stat_01" : 0,
    "epic_stat_02" : 0,
    "epic_stat_03" : 0,
    "epic_stat_04" : 0,
    "upgrades": current_upgrades
}
func reset_game_data() -> void:
    current_upgrades = {
        "upgrade_food_dense" : 0
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
        "bacterias" : 1,
        "petri_dishes" : 0,
        "player_archived_game_goal" : 0,
        "upgrades": current_upgrades
}