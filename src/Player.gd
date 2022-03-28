extends KinematicBody2D

var speed = 200 # How fast the player will move (pixels/sec).
var screen_size 
var interact_ingredient = false

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	move_and_slide(Vector2(x_input, y_input)*speed)
		
	if x_input != 0 || y_input != 0:
		if x_input != 0: 
			$AnimatedSprite.play("side")
			$AnimatedSprite.flip_h = x_input > 0
		if y_input != 0:
			if y_input > 0:
				$AnimatedSprite.play("down")
			else:
				$AnimatedSprite.play("up")
	else:
		$AnimatedSprite.play("idle")
	
func pick_up_ingredient():
	pass
