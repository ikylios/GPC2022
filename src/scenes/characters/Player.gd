extends KinematicBody2D

var speed = 150 # How fast the player will move (pixels/sec).
var carried_item = null
var carried_item_sprite = null

func _physics_process(delta):
	if Input.is_action_just_pressed("toss") and carried_item:
		drop_carried_item()
	
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


# ------------------- Item functionalities ----------------------

func get_carried_item():
	return carried_item
	
func set_carried_item(item):
	carried_item = item
	print("picked up ", item)
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
