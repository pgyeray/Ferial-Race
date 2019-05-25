extends Area2D
# Tile generator script

onready var timer = Global.difficulty
onready var tile_scene = load("res://resources/tiles/Tile.tscn")

onready var peluche = preload("res://assets/img/tiles/peluche.png")
onready var vino = preload("res://assets/img/tiles/botella_vino.png")
onready var jamon = preload("res://assets/img/tiles/jamon.png")
onready var pan = preload("res://assets/img/tiles/pan.png")

onready var pan_destroy_1 = preload("res://assets/img/tiles/destroy_sprites/pan/pan_destroy_1.png")
onready var pan_destroy_2 = preload("res://assets/img/tiles/destroy_sprites/pan/pan_destroy_2.png")
onready var pan_destroy_3 = preload("res://assets/img/tiles/destroy_sprites/pan/pan_destroy_3.png")

onready var jamon_destroy_1 = preload("res://assets/img/tiles/destroy_sprites/jamon/jamon_destroy_1.png")
onready var jamon_destroy_2 = preload("res://assets/img/tiles/destroy_sprites/jamon/jamon_destroy_2.png")
onready var jamon_destroy_3 = preload("res://assets/img/tiles/destroy_sprites/jamon/jamon_destroy_3.png")

onready var vino_destroy_1 = preload("res://assets/img/tiles/destroy_sprites/vino/vino_destroy_1.png")
onready var vino_destroy_2 = preload("res://assets/img/tiles/destroy_sprites/vino/vino_destroy_2.png")
onready var vino_destroy_3 = preload("res://assets/img/tiles/destroy_sprites/vino/vino_destroy_3.png")

onready var peluche_destroy_1 = preload("res://assets/img/tiles/destroy_sprites/peluche/peluche_destroy_1.png")
onready var peluche_destroy_2 = preload("res://assets/img/tiles/destroy_sprites/peluche/peluche_destroy_2.png")
onready var peluche_destroy_3 = preload("res://assets/img/tiles/destroy_sprites/peluche/peluche_destroy_3.png")

onready var textures = [peluche, vino, jamon, pan]
onready var destroy_textures = [
	[peluche_destroy_1, peluche_destroy_2, peluche_destroy_3],	
	[vino_destroy_1, vino_destroy_2, vino_destroy_3],
	[jamon_destroy_1, jamon_destroy_2, jamon_destroy_3],
	[pan_destroy_1, pan_destroy_2, pan_destroy_3]
]

const RANGES = [355, 255, 155, 55]; # the offset is backwards
const TYPES = ["A","S","D","F"]

func _process(delta):
	if not Global.finished:
		timer += delta; ### the sum amount of delta in X sec is X
		if timer >= Global.difficulty:
			var tiles;
			
			## set multiple_tile_ratio according to the difficulty ##
			## see Global.gd
			var multiple_tile_ratio = Global.map(Global.difficulty, Global.MAX_DIF, Global.MINDIF_TOMULT, Global.MAX_MULT_RATIO, 0);
	
			if (randf() > multiple_tile_ratio):
				tiles = generate_tiles(1);
			else:
				## see Global.gd
				var set_max_interval = Global.map(Global.difficulty, Global.MAX_DIF, Global.MINDIF_TOMULT, Global.QUANT_TILES_I, 0); # sets the range
				var how_many_tiles = floor(randf()*set_max_interval + 2) as int; ## generates the random val as int
				
				tiles = generate_tiles(how_many_tiles);
			
			add_children(tiles);
			
			timer = 0
		
## Returns a non-type-repeated-tile array
func generate_tiles(size):
	var tiles = [];
	var random = randi()%4;
	
	## Creates the first tile -- No checks
	tiles.append(create_tile(random));
	for i in range(size-1):
		random = randi()%4;
		while check_random(random, tiles):
			random = randi()%4;
			
		## Now we got a different random number
		tiles.append(create_tile(random));		
	return tiles;

func create_tile(random):
	var tile = tile_scene.instance();
	
	var animated_sprite = AnimatedSprite.new();
	animated_sprite.name = "Sprite";
	animated_sprite.set_sprite_frames(generate_sprites(random));

	tile.add_child(animated_sprite)
	tile.start(generate_pos_vector(random), TYPES[random]);
	return tile;
	
func generate_sprites(random):
	AnimationPlayer
	var sprite_frames = SpriteFrames.new();
	sprite_frames.add_animation("idle");
	sprite_frames.add_animation("destroy");
	sprite_frames.set_animation_loop("destroy", false);
	sprite_frames.add_frame("idle", textures[random], 0);
	
	for i in range(3):
		sprite_frames.add_frame("destroy", destroy_textures[random][i], i);
		
	return sprite_frames;
	
func generate_pos_vector(random):
	return Vector2(position.x - RANGES[random], position.y);
	
func check_random(random, tiles):
	for tile in tiles:
		if TYPES[random] == tile.type:
			return true;
	
	return false;
	
func add_children(tiles):
	for tile in tiles:
		add_child(tile);