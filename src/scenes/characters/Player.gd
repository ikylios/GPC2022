extends KinematicBody2D

var speed = 120 # How fast the player will move (pixels/sec).
var carried_item = null
var carried_item_sprite = null
var prev_direction = "down"

enum states {IDLE, WALK, CARRY, IDLE_CARRY}
var movement_state = states.IDLE

func _physics_process(delta):
	if Input.is_action_just_pressed("toss") and carried_item:
		drop_carried_item()
	
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	move_and_slide(Vector2(x_input, y_input)*speed)
	
	var direction = input_to_direction(x_input, y_input)
	var animation = format_animation_name(direction)

	if movement_state == states.CARRY or movement_state == states.IDLE_CARRY:
		update_sprite_position(direction)
	
	$AnimatedSprite.play(animation)


func format_animation_name(direction):
	if movement_state == states.IDLE:
		return str(direction) + "_idle"
	if movement_state == states.CARRY:
		return "carry_" + str(direction)
	if movement_state == states.IDLE_CARRY:
		return "carry_" + str(direction) + "_idle"
	else:
		return direction

func input_to_direction(x, y):
	var result = ""
		
	if x != 0 || y != 0:
		if carried_item:
			movement_state = states.CARRY
		else:
			movement_state = states.WALK
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
		if carried_item:
			movement_state = states.IDLE_CARRY
		else:
			movement_state = states.IDLE
		result += prev_direction
		
	prev_direction = result
	
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
	carried_item_sprite.set_scale(Vector2(0.75, 0.75))
	add_child(carried_item_sprite)
	update_sprite_position(prev_direction)
	
func update_sprite_position(direction):
	if "right" in direction:
		carried_item_sprite.position = Vector2($AnimatedSprite.position.x - 5, $AnimatedSprite.position.y - 25)
		carried_item_sprite.set_z_index(-1)
	elif "left" in direction:
		carried_item_sprite.position = Vector2($AnimatedSprite.position.x + 5, $AnimatedSprite.position.y - 25)
		carried_item_sprite.set_z_index(0)
	elif "up" in direction:
		carried_item_sprite.position = Vector2($AnimatedSprite.position.x - 10, $AnimatedSprite.position.y - 25)
		carried_item_sprite.set_z_index(-1)
	elif "down" in direction:
		carried_item_sprite.position = Vector2($AnimatedSprite.position.x + 10, $AnimatedSprite.position.y - 25)
		carried_item_sprite.set_z_index(0)

func drop_carried_item():
	carried_item = null
	remove_child(carried_item_sprite)
