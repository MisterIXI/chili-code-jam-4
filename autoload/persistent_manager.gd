extends Node

@onready var _timer : Timer = $Timer

################################## Functions ##################################
func _ready() -> void:
    ### DEBUG 
    delete_game_data()
    ### /DEBUG
    _timer.timeout.connect(_on_timer_timeout)
    #Load existing game data if available
    load_game_data()

func on_timer_waittime_changed(_value :float) ->void:
    if _value >0:
        _timer.wait_time = _value
        print("Persistent_Manager: Save Interval")
func _on_timer_timeout() -> void:
    if GameData.s_save_game_data == 1:
        save_game_data()

##################### DATA SAVE, LOAD AND RESET METHODS #####################
func save_game_data() -> void:
    var data_to_save : Dictionary = {
        ## upgrades
        "food_drop_max" : GameData.u_food_drop_max,
        "petri_dishes" : GameData.u_petri_dishes,
        "bacteria_speed" : GameData.u_bacteria_speed, 
        "bacteria_division_cdr" : GameData.u_bacteria_division_cdr,
        "basic_graphs" : GameData.u_basic_graphs, 
        "advanced_graphs" : GameData.u_advanced_graphs, 
        "auto_upgrader" :GameData.u_auto_upgrader,
        # settings
        "master_volume" : GameData.s_master_volume,
        "music_volume" : GameData.s_music_volume,
        "sound_volume" : GameData.s_sound_volume,
        "fullscreen" : GameData.s_fullscreen,
        "fps_counter" : GameData.s_fps_counter,
        "max_bacterias" : GameData.s_max_bacterias,
        "save_game_data" : GameData.s_save_game_data,
        "save_interval" :GameData.s_save_interval,
        ## progress
        "dna_currency" : GameData.p_dna_currency,
        "total_bacterias_spawned" : GameData.p_total_bacterias_spawned,
        "bacterias" : GameData.p_bacterias,
        "food_slider" : GameData.p_food_slider,
        "player_archived_game_goal" : GameData.p_player_archived_game_goal
    }

    # Create a ConfigFile to save the data
    var config = ConfigFile.new()
    #Store the data in the config file
    config.set_value("game_data", "data", data_to_save)
    # Save the config file to disk
    var err = config.save("user://save_game.cfg")
    if err != OK:
        print("Error saving game data: ", err)
    else :
        print("Game data saved successfully.")
    

func load_game_data() -> void:
    # Create a ConfigFile to load the data
    var config = ConfigFile.new()

    # Load the config file from disk
    var err = config.load("user://save_game.cfg")
    # If the file didn't load successfully, return
    if err != OK:
        print("No save file found, starting new game.")
        GameData.reset_game_data()
        return
    # Retrieve the saved data
    var saved_data = config.get_value("game_data", "data", null)
    # If saved data exists, populate the variables
    if saved_data != null:
        
        ## Load data from saved_data with get value
        ## Upgrades
        GameData.u_food_drop_max = saved_data.get("food_drop_max", 0)
        GameData.u_petri_dishes  = saved_data.get("petri_dishes", 0)
        GameData.u_bacteria_speed  = saved_data.get("bacteria_speedx", 0)
        GameData.u_bacteria_division_cdr = saved_data.get("bacteria_division_cdr", 0)
        GameData.u_basic_graphs  =saved_data.get("basic_graphs", 0)
        GameData.u_advanced_graphs = saved_data.get("advanced_graphs", 0)
        GameData.u_auto_upgrader =saved_data.get("auto_upgrader", 0)
        ### Settings
        GameData.s_master_volume = saved_data.get("master_volume", 0.0)
        GameData.s_music_volume = saved_data.get("music_volume", 0.0)
        GameData.s_sound_volume =saved_data.get("sound_volume", 0.0)
        GameData.s_fullscreen =saved_data.get("fullscreen", 0)
        GameData.s_fps_counter  =saved_data.get("fps_counter", 0)
        GameData.s_max_bacterias  =saved_data.get("max_bacterias", 0)
        GameData.s_save_game_data  =saved_data.get("save_game_data", 0)
        GameData.s_save_interval=saved_data.get("save_interval", 0)
        ### Progress
        GameData.p_dna_currency  = saved_data.get("dna_currency", 0.0)
        GameData.p_total_bacterias_spawned  = saved_data.get("total_bacterias_spawned", 0.0)
        GameData.p_bacterias = saved_data.get("bacterias", 0.0)
        GameData.p_food_slider  = saved_data.get("food_slider", 0.0)
        GameData.p_player_archived_game_goal =saved_data.get("player_archived_game_goal", 0)

        print("Game data loaded successfully.")
    else:
        print("No saved data found in the save file.")

func delete_game_data() ->void:
    GameData.reset_game_data()
    save_game_data()
    print("Persistent_Manager: Delete savegamedata")