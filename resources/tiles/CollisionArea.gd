extends Area2D
# CollsionArea script

onready var coin_player = get_node("../AudioStreamPlayer");

var TYPES = ["A","S","D","F"]
	
func _input(event):
	if not Global.finished:
		if event is InputEventKey and event.is_pressed():
			var tiles = get_overlapping_bodies();
			match event.scancode:
				KEY_A:
					checkTiles(tiles, TYPES[0])
				KEY_S:
					checkTiles(tiles, TYPES[1])
				KEY_D:
					checkTiles(tiles, TYPES[2])
				KEY_F:
					checkTiles(tiles, TYPES[3])
				
func checkTiles(tiles, type):
	for tile in tiles:
		if tile.type == type:
			coin_player.play();
			tile._dispose();
			Global.match_tile();
			return;	
	
	# disposed none
	# 
	Global.tile_failed();
			