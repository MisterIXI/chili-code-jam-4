extends Node

var _master_volume : float = 0.5
var _music_volume : float = 0.5
var _sound_volume : float = 0.5

var _audio_bus_master : int = 0
var _audio_bus_music : int = 0 
var _audio_bus_sound : int = 0

func _ready() -> void:
    _audio_bus_master = AudioServer.get_bus_index("Master")
    _audio_bus_music = AudioServer.get_bus_index("Music")
    _audio_bus_sound = AudioServer.get_bus_index("Sound")
    _initiale_volume()

func _initiale_volume() ->void:
    _master_volume = GameData.game_settings ["master_volume"]
    _music_volume = GameData.game_settings ["music_volume"]
    _sound_volume = GameData.game_settings ["sound_volume"]
    
    set_volume(_audio_bus_master, _master_volume)
    set_volume(_audio_bus_music, _music_volume)
    set_volume(_audio_bus_sound,_sound_volume)

func set_volume(index : int, _value) ->void:
    match index:
        _audio_bus_master:
            _master_volume = _value
            var volume_db = linear_to_db(_value) # A simple mapping example
            print("Volume_db: ", volume_db)
            AudioServer.set_bus_volume_db(_audio_bus_master, volume_db)
            GameData.game_settings ["master_volume"] = _value

        _audio_bus_music:
            _music_volume = _value
            var volume_db = linear_to_db(_value) # A simple mapping example
            print("Volume_db: ", volume_db)
            AudioServer.set_bus_volume_db(_audio_bus_music, volume_db)
            GameData.game_settings ["music_volume"] = _value
        _audio_bus_sound:
            _sound_volume = _value
            var volume_db = linear_to_db(_value) # A simple mapping example
            print("Volume_db: ", volume_db)
            AudioServer.set_bus_volume_db(_audio_bus_sound, volume_db)
            GameData.game_settings ["sound_volume"] = _value

        _:
            print("Sound_Manager: error, cant find a index of sound change on SET_VOLUME : ", index)

