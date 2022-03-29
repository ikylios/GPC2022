extends KinematicBody2D

var speed = 200 # How fast the player will move (pixels/sec).
var screen_size 
var carried_ingredient = null
var carried_sprite = null

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
		move_carried_sprite()
	else:
		$AnimatedSprite.play("idle")
		
	
func _on_Ingredient_picked_up(type):
	carried_ingredient = type
	
	var path = "res://assets/ingredients/"
	match type:
		"potato": path += "Potato.png"
		"steak": path = "Steak.png"
	set_carried_sprite(path)

func set_carried_sprite(path):
	carried_sprite = Sprite.new()
	carried_sprite.set_texture(load(path))
	move_carried_sprite()
	add_child(carried_sprite)

func move_carried_sprite():
	if carried_sprite != null:
		carried_sprite.position = Vector2($AnimatedSprite.position.x, $AnimatedSprite.position.y - 30)
