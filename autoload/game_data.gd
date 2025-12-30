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
    "show_fps" : 1,
    "max_bacterias" : 1000,
    "save_game_data" : 1,
    "save_interval" :60
}
var player_progress : Dictionary = {
    "bacterias" : 1,
    "petri_dishes" : 0, # total distance traveled in kilometers (astronomical units)
    "player_archived_game_goal" : 0,
    "epic_stat_01" : 0,
    "epic_stat_02" : 0,
    "epic_stat_03" : 0,
    "epic_stat_04" : 0,
    "upgrades": current_upgrades
}