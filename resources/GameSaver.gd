extends Node

const PATH_DIR = "res://.data"
const FILENAME = "scoreboard.sve"
const FULL_PATH = PATH_DIR + "/" + FILENAME;
const MAX_TABLE_SIZE = 10;

### Score data ###
var init_race
var elapsed_racetime
var player_position = 1;
var nickname;

var ScoreBoard = {}

# initialize stuff here
func _ready():
	# first determine if a Saves directory exists.
	# if it doesn't, create it.
	var dir = Directory.new()
	if !dir.dir_exists(PATH_DIR):
	 	dir.open(PATH_DIR)
	 	dir.make_dir(PATH_DIR)
	
	init_save()
	
	save_game_state();
	
# Stores the table to file
func save_game_state():
	var file = File.new();
	file.open(FULL_PATH, File.WRITE);
	file.store_line(to_json(ScoreBoard));
	
	file.close();
	
# Reads the file and stores it to ScoreBoard
func load_game_state():
	var file = File.new();
	
	if !file.file_exists(FULL_PATH):
		print("File not found! Aborting...")
		return

	var currentLine = {}
	
	file.open(FULL_PATH, File.READ)
	var data_text = file.get_as_text()
	file.close()
	
	print(data_text)
	
	var data_parse = JSON.parse(data_text)
	if(data_parse.error != OK):
		return
	
	ScoreBoard = data_parse.get_result()

#Necesaria para el primer inicio del programa en el equipo
func init_save():
	var saveGame = File.new()

	# see if the file actually exists before opening it
	if !saveGame.file_exists(FULL_PATH):
		saveGame.open(FULL_PATH, File.WRITE)
		var data = ScoreBoard
		saveGame.store_line(to_json(data))
		saveGame.close()
	else:
		# read file and store to ScoreBoard
		load_game_state();

func save_score ():
	var score = {
		name = nickname,
		position = player_position,
		time = elapsed_racetime
	};
	
	## TODO : check if valid
	ScoreBoard[ScoreBoard.size()] = score;
	
	save_game_state()
	
func i_save_score (name, position, time):
	var score = {
		name = name,
		position = position,
		time = time
	};
	
	## TODO : check if valid
	ScoreBoard[ScoreBoard.size()] = score;