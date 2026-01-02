extends Node
### Audio Player
@onready var _music_player : AudioStreamPlayer  =$music_player
@onready var _music_menu_player : AudioStreamPlayer  =$music_menu
@onready var _bacteria_division_sound : AudioStreamPlayer = $Bacteria_division
@onready var _UI_Click_sound : AudioStreamPlayer = $UI_Click
@onready var _UI_Error : AudioStreamPlayer = $UI_Error
### Settings
var _master_volume : float = 0.5
var _music_volume : float = 0.5
var _sound_volume : float = 0.5

var _audio_bus_master : int = 0
var _audio_bus_music : int = 0 
var _audio_bus_sound : int = 0

#################################### GLOBAL PLAY FUNCTIONS
func play_game_music() ->void:
    _music_menu_player.stop()
    _music_player.play()

func play_menu_music() ->void:
    _music_player.stop()
    _music_menu_player.play()

func play_division_sound() ->void:
    _bacteria_division_sound.play()

func play_click() ->void:
    _UI_Click_sound.play()

func play_error() ->void:
    _UI_Error.play()

func set_volume(index : int, _value) ->void:
    match index:
        _audio_bus_master:
            _master_volume = _value
            var volume_db = linear_to_db(_value) # A simple mapping example
            print("Volume_db: ", volume_db)
            AudioServer.set_bus_volume_db(_audio_bus_master, volume_db)
            GameData.s_master_volume = _value
        _audio_bus_music:
            _music_volume = _value
            var volume_db = linear_to_db(_value) # A simple mapping example
            print("Volume_db: ", volume_db)
            AudioServer.set_bus_volume_db(_audio_bus_music, volume_db)
            GameData.s_music_volume = _value
        _audio_bus_sound:
            _sound_volume = _value
            var volume_db = linear_to_db(_value) # A simple mapping example
            print("Volume_db: ", volume_db)
            AudioServer.set_bus_volume_db(_audio_bus_sound, volume_db)
            GameData.s_sound_volume = _value
        _:
            print("Sound_Manager: error, cant find a index of sound change on SET_VOLUME : ", index)


############### SCRIPT BASED FUNCTIONS
func _ready() -> void:
    _audio_bus_master = AudioServer.get_bus_index("Master")
    _audio_bus_music = AudioServer.get_bus_index("Music")
    _audio_bus_sound = AudioServer.get_bus_index("Sound")
    PersistentManager.game_data_loaded.connect(_on_game_data_loaded)

func _on_game_data_loaded()->void:    
    _initiale_volume()

####################### / BASED FUNCTIONS
#Private functions
func _initiale_volume() ->void:
    _master_volume = GameData.s_master_volume
    _music_volume = GameData.s_music_volume
    _sound_volume = GameData.s_sound_volume
    
    set_volume(_audio_bus_master, _master_volume)
    set_volume(_audio_bus_music, _music_volume)
    set_volume(_audio_bus_sound,_sound_volume)


