extends KinematicBody2D

var speed = 200 # How fast the player will move (pixels/sec).
var screen_size 
var carried_ingredient = null
var carried_ingredient_sprite = null

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
		move_carried_ingredient_sprite()
	else:
		$AnimatedSprite.play("idle")

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_C:
			throw_away_carried_ingredient()

# ------------------- Ingredient functionalities ----------------------

func _on_Ingredient_box_interacted(path, ingredient):
	if !carried_ingredient:
		carried_ingredient = ingredient
		set_carried_ingredient_sprite(path)

func set_carried_ingredient_sprite(path):
	carried_ingredient_sprite = Sprite.new()
	carried_ingredient_sprite.set_texture(load(path))
	add_child(carried_ingredient_sprite)
	move_carried_ingredient_sprite()

func move_carried_ingredient_sprite():
	if carried_ingredient_sprite:
		carried_ingredient_sprite.position = Vector2($AnimatedSprite.position.x, $AnimatedSprite.position.y - 30)

func throw_away_carried_ingredient():
	carried_ingredient = null
	remove_child(carried_ingredient_sprite)
