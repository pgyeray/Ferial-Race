extends KinematicBody2D
# Camel script

var motion = Vector2();
var speed = 0;
var finished = false

func start(speed):
	self.speed = speed;

func _process(delta):
	if not finished:
		update_speed();
		
		motion.x += speed * delta;
		motion = move_and_slide(motion);
	
func stop():
	finished = true;
	get_node("Sprite").play("idle");
	
func update_speed():
	if randf() < 0.5:
		speed += Global.OPONENT_SPEED_VARIANT if speed < Global.MAX_OPONENT_SPEED else 0;
	else:
		speed -= Global.OPONENT_SPEED_VARIANT if speed > Global.MIN_OPONENT_SPEED else 0;
	