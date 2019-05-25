extends Node2D

onready var camel_template = load("res://resources/oponents/Camel.tscn")

const X_START = 520;
const Y_START = 190;
const Y_OFFSET = 110;

var sprite_blue
var sprite_red
var sprite_white
var sprite_purple
var sprite_green
var sprite_yellow

onready var blue_idle = preload("res://assets/img/camels/blue/blue-1.png")
onready var blue_run_1 = preload("res://assets/img/camels/blue/blue-2.png")
onready var blue_run_2 = preload("res://assets/img/camels/blue/blue-3.png")
onready var blue_run_3 = preload("res://assets/img/camels/blue/blue-4.png")

onready var green_idle = preload("res://assets/img/camels/green/green-1.png")
onready var green_run_1 = preload("res://assets/img/camels/green/green-2.png")
onready var green_run_2 = preload("res://assets/img/camels/green/green-3.png")
onready var green_run_3 = preload("res://assets/img/camels/green/green-4.png")

onready var purple_idle = preload("res://assets/img/camels/purple/purple-1.png")
onready var purple_run_1 = preload("res://assets/img/camels/purple/purple-2.png")
onready var purple_run_2 = preload("res://assets/img/camels/purple/purple-3.png")
onready var purple_run_3 = preload("res://assets/img/camels/purple/purple-4.png")

onready var red_idle = preload("res://assets/img/camels/red/red-1.png")
onready var red_run_1 = preload("res://assets/img/camels/red/red-2.png")
onready var red_run_2 = preload("res://assets/img/camels/red/red-3.png")
onready var red_run_3 = preload("res://assets/img/camels/red/red-4.png")

onready var white_idle = preload("res://assets/img/camels/white/white-1.png")
onready var white_run_1 = preload("res://assets/img/camels/white/white-2.png")
onready var white_run_2 = preload("res://assets/img/camels/white/white-3.png")
onready var white_run_3 = preload("res://assets/img/camels/white/white-4.png")

onready var yellow_idle = preload("res://assets/img/camels/yellow/yellow-1.png")
onready var yellow_run_1 = preload("res://assets/img/camels/yellow/yellow-2.png")
onready var yellow_run_2 = preload("res://assets/img/camels/yellow/yellow-3.png")
onready var yellow_run_3 = preload("res://assets/img/camels/yellow/yellow-4.png")


var animated_sprites

var posy = Y_START;
var index = 0;

func _ready():
	randomize(); ## resets the random generator seed
	
	load_sprites();	
	animated_sprites = [sprite_blue, sprite_green, sprite_white, sprite_red, sprite_yellow];
	
	for i in range(5):
		var camel = camel_template.instance();
		
		var speed = randf()*(Global.MAX_OPONENT_SPEED-Global.MIN_OPONENT_SPEED) + Global.MIN_OPONENT_SPEED;
		camel.start(speed);
		
		var animated_sprite = AnimatedSprite.new();
		animated_sprite.set_sprite_frames(animated_sprites[index%6]);
		animated_sprite.name = "Sprite";
		animated_sprite.set_speed_scale(Global.map(speed,Global.MIN_OPONENT_SPEED,Global.MAX_OPONENT_SPEED,1,2))
		
		camel.add_child(animated_sprite);
		
		camel.position = Vector2(X_START, posy);
		camel.get_node("Sprite").play("run");
		
		add_child(camel);
		
		index += 1;
		posy += Y_OFFSET;
	
	GameSaver.player_position = 1;
	GameSaver.init_race = OS.get_ticks_msec()

func load_sprites():
	
	sprite_blue = SpriteFrames.new()
	sprite_blue.add_animation("idle")
	sprite_blue.add_animation("run")
	sprite_blue.add_frame("idle", blue_idle, 0)
	sprite_blue.add_frame("run", blue_run_1, 0)
	sprite_blue.add_frame("run", blue_run_2, 1)
	sprite_blue.add_frame("run", blue_run_3, 2)
	
	sprite_green = SpriteFrames.new()
	sprite_green.add_animation("idle")
	sprite_green.add_animation("run")
	sprite_green.add_frame("idle", green_idle, 0)
	sprite_green.add_frame("run", green_run_1, 0)
	sprite_green.add_frame("run", green_run_2, 1)
	sprite_green.add_frame("run", green_run_3, 2)
	
	sprite_purple = SpriteFrames.new()
	sprite_purple.add_animation("idle")
	sprite_purple.add_animation("run")
	sprite_purple.add_frame("idle", purple_idle, 0)
	sprite_purple.add_frame("run", purple_run_1, 0)
	sprite_purple.add_frame("run", purple_run_2, 1)
	sprite_purple.add_frame("run", purple_run_3, 2)
	
	sprite_red = SpriteFrames.new()
	sprite_red.add_animation("idle")
	sprite_red.add_animation("run")
	sprite_red.add_frame("idle", red_idle, 0)
	sprite_red.add_frame("run", red_run_1, 0)
	sprite_red.add_frame("run", red_run_2, 1)
	sprite_red.add_frame("run", red_run_3, 2)
	
	sprite_white = SpriteFrames.new()
	sprite_white.add_animation("idle")
	sprite_white.add_animation("run")
	sprite_white.add_frame("idle", white_idle, 0)
	sprite_white.add_frame("run", white_run_1, 0)
	sprite_white.add_frame("run", white_run_2, 1)
	sprite_white.add_frame("run", white_run_3, 2)
	
	sprite_yellow = SpriteFrames.new()
	sprite_yellow.add_animation("idle")
	sprite_yellow.add_animation("run")
	sprite_yellow.add_frame("idle", yellow_idle, 0)
	sprite_yellow.add_frame("run", yellow_run_1, 0)
	sprite_yellow.add_frame("run", yellow_run_2, 1)
	sprite_yellow.add_frame("run", yellow_run_3, 2)
	