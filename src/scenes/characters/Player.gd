extends KinematicBody2D

var speed = 120 # How fast the player will move (pixels/sec).
var carried_item = null
var carried_item_sprite = null

func _physics_process(delta):
	if Input.is_action_just_pressed("toss") and carried_item:
		drop_carried_item()
	
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	move_and_slide(Vector2(x_input, y_input)*speed)
	var direction = input_to_direction(x_input, y_input)
	$AnimatedSprite.play(direction)

func input_to_direction(x, y):
	var result = ""
	if carried_item:
		result = "carry_"
		
	if x != 0 || y != 0:
		if x != 0:
			if y > 0:
				result += "down"
			elif y < 0:
				result += "up"
			else:
				if x < 0:
					result += "left"
				else:
					result += "right"
		
		elif y != 0:
			if y > 0:
				result += "down"
			else:
				result += "up"
	else:
		result += "idle"
	
	return result



# ------------------- Item functionalities ----------------------

func get_carried_item():
	return carried_item
	
func set_carried_item(item):
	carried_item = item
	set_carried_item_sprite(item.path)

func _on_Ingredient_box_interacted(item):
	set_carried_item(item)

func set_carried_item_sprite(path):
	remove_child(carried_item_sprite)
	
	carried_item_sprite = Sprite.new()
	carried_item_sprite.set_texture(load(path))
	add_child(carried_item_sprite)
	carried_item_sprite.position = Vector2($AnimatedSprite.position.x, $AnimatedSprite.position.y - 30)

func drop_carried_item():
	carried_item = null
	remove_child(carried_item_sprite)
