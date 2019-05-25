extends KinematicBody2D
# Main Camel script

var motion = Vector2()

func _ready():
	self.get_node("Sprite").play("run")

func _process(delta):
	if not Global.finished:
		motion.x += Global.player_speed * delta;
		motion = move_and_slide(motion);
	else:
		self.get_node("Sprite").play("idle");
	