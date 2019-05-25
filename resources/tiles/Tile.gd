extends KinematicBody2D
# Tile script

var type;
var anim;
var finished;
	
func start (pos, type):
	finished = false;
	position = pos;
	self.type = type;
	anim = get_node("./Sprite");
	anim.play('idle');

### No physics needed ###
func _process(delta):
	if (not finished):
		position.y += Global.speed_tiles * delta;

	if position.y > 800:
		Global.tile_failed();
		_free();
		
func _dispose():
	finished = true;
	anim.play("destroy");
	yield(get_tree().create_timer(0.5), "timeout")

	_free();

func _free():
	queue_free();
	
