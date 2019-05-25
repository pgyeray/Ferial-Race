extends Node

### Difficulty Settings ###
const MAX_DIF = 0.6; 
const MIN_DIF = 1.7;
const DIFFICULTY_VARIANT = 0.08;
const DIFFICULTY_STEPS = (MIN_DIF - MAX_DIF) / DIFFICULTY_VARIANT;
const STARTING_DIF = 1.6;

### Tile Speed Settings ###
const MAX_TILE_SPEED = 300;
const MIN_TILE_SPEED = 200;
var TILE_SPEED_VARIANT;

### Player Speed Settings ###
var MAX_PLAYER_SPEED = 20;
const MIN_PLAYER_SPEED = 0;
var PLAYER_SPEED_VARIANT;

### Oponents Speed Settings ###
const MAX_OPONENT_SPEED = 15;
const MIN_OPONENT_SPEED = 5;
const OPONENT_SPEED_VARIANT = 1;

### Multiplier Settings ###
const MAX_MULTIPLIER = 1.7;
const MIN_MULTIPLIER = 1;

### MultiTile Settings ###
const MINDIF_TOMULT = 1.5; # Minimum difficulty to get multiple tiles
# Starting from 2, the ratio of multiple tiles [0-3)
# x = 0-1: 100% 2 tiles
# x = 1-2: 100*(x-1)% 3 tiles, the rest 2
# x = 2-3: 100*(x-2)% 4 tiles, half of the rest 3, half of the res 2
const QUANT_TILES_I = 1.2;
const MAX_MULT_RATIO = 0.8; # Maximum ratio to get multiple tiles at MAX_DIF

## Control variables ##
var finished;
var multiplier = MIN_MULTIPLIER;
var difficulty = STARTING_DIF;
var speed_tiles;
var player_speed;

### Runtime Nodes ###
var player_sprite;
var popup;

func _set_it_up():
	finished = false;
	TILE_SPEED_VARIANT = (MAX_TILE_SPEED - MIN_TILE_SPEED) / DIFFICULTY_STEPS;
	PLAYER_SPEED_VARIANT = (MAX_PLAYER_SPEED - MIN_PLAYER_SPEED) / DIFFICULTY_STEPS;
	
	difficulty = STARTING_DIF;
	multiplier = MIN_MULTIPLIER;
	speed_tiles = Global.map(difficulty, MAX_DIF, MIN_DIF, MAX_TILE_SPEED, MIN_TILE_SPEED);
	player_speed = Global.map(difficulty, MAX_DIF, MIN_DIF, MAX_PLAYER_SPEED, MIN_PLAYER_SPEED);

## Must be called into SplitScreen scope ##
func load_player_sprite():
	player_sprite = get_node("/root/SplitScreen/Screen/RaceView/Viewport/Race/MainCamel/Sprite")
	
## Must be called into SplitScreen scope ##
func load_popup():
	popup = get_node("/root/SplitScreen/Popup");
	
func show_popup():
	popup.popup();

func match_tile():
	Global.harderDifficulty();
	Global.speed_up();
	Global.upgrade_multiplier();
	
func tile_failed():
	Global.lowerDifficulty();
	Global.speed_down();
	Global.reset_multiplier();

func harderDifficulty():
	difficulty -= DIFFICULTY_VARIANT if difficulty > MAX_DIF else 0;
	speed_tiles += TILE_SPEED_VARIANT if speed_tiles < MAX_TILE_SPEED else 0
	
func lowerDifficulty():
	difficulty += DIFFICULTY_VARIANT if difficulty < MIN_DIF else 0;
	speed_tiles -= TILE_SPEED_VARIANT if speed_tiles > MIN_TILE_SPEED else 0

func speed_up():
	player_speed += PLAYER_SPEED_VARIANT * multiplier if player_speed < MAX_PLAYER_SPEED else 0;
	set_animation_rate();
	
func speed_down():
	player_speed -= PLAYER_SPEED_VARIANT * multiplier if player_speed > MIN_PLAYER_SPEED else 0;
	set_animation_rate();

func upgrade_multiplier():
	multiplier += 0.1 if multiplier <= MAX_MULTIPLIER else 0;
	
func reset_multiplier():
	multiplier = MIN_MULTIPLIER;
	
func set_animation_rate():
	player_sprite.set_speed_scale(Global.map(player_speed, MIN_PLAYER_SPEED, MAX_PLAYER_SPEED, 1, 2))

static func map(value, i_min_val, i_max_val, o_min_val, o_max_val):
	if value <= i_min_val: return o_min_val;
	if value >= i_max_val: return o_max_val; 
	return o_min_val + (o_max_val - o_min_val) * ((value - i_min_val) / (i_max_val - i_min_val));