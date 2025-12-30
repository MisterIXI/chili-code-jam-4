extends Node

@onready var _timer : Timer = $Timer

################################## Functions ##################################
func _ready() -> void:
    ### DEBUG 
    #GameData.reset_game_data()
    ### /DEBUG
    _timer.timeout.connect(_on_timer_timeout)
    _timer.start()
    #Load existing game data if available
    load_game_data()

func _on_timer_timeout() -> void:
    if GameData.game_settings["save_game_data"] == 1:
        save_game_data()

##################### DATA SAVE, LOAD AND RESET METHODS #####################
func save_game_data() -> void:
    var data_to_save : Dictionary = {
        "game_settings" : GameData.game_settings,
        "player_progress" : GameData.player_progress
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
        GameData.game_settings = saved_data.get("game_settings", GameData.game_settings)
        GameData.player_progress = saved_data.get("player_progress", GameData.player_progress)
        print("Game data loaded successfully.")
    else:
        print("No saved data found in the save file.")

func delete_game_data() ->void:
    GameData.reset_game_data()
    save_game_data()
    print("Persistent_Manager: Delete savegamedata")