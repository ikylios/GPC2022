extends "res://scenes/characters/Interactable_movable.gd"

var order
var order_list = ["spydäri", "ranskikset"]
var received_order = null
var received_order_sprite
var player
var speed = 1000
var velocity = Vector2()
#var path = [global_position, Vector2(120,120), Vector2(270,270), Vector2(70,70)]
var path = []
var spawn_area = [Vector2(611, 210), Vector2(742, 295)]
var target

func _ready():
	order = generate_order()
	$AnimatedSprite.play("idle")
	add_to_group("new_customers")
	position.x = (randi() % 117) + 611
	position.y = (randi() % 70) + 210

func _process(_delta):
	$AnimatedSprite.playing = interactable

func _physics_process(delta):
	if get_parent().is_class("PathFollow2D"):
		get_parent().offset += speed * delta




# ----------- physics trial -----------------
#func _physics_process(delta):
	#get_input()
	#move_and_collide(velocity * delta)
#	velocity = Vector2.ZERO
	
#	if !path.empty():
#		velocity = position.direction_to(path[path.size()-1]) * speed
	#else: velocity = Vector2.ZERO
#	velocity = move_and_slide(velocity)

		#var dir = (target - position).normalized()
		#var move_amount = Vector2(move_toward(position.x, target.x, dir.x * speed  * delta), move_toward(position.y, target.y, dir.y * speed * delta))
		#move_and_collide(move_amount) # or move_and_slide(move_amount / delta)

# -------------- Interaction --------------

func waiting_on_meal():
	return self in get_tree().get_nodes_in_group("customers")

func interact():
	player = get_parent().get_node("Player")
	var meal = player.get_carried_item()
	
	if waiting_on_meal() and meal:
		if try_to_receive_meal(meal):
			player.drop_carried_item()
	elif !received_order:
		$Order_bubble.display_order(order)
		
	
	
# -------------- Moving functionalities --------------

func get_input():
	if path.size() > 0:
		velocity = global_position.direction_to(path[0]) * speed
		
		if are_close(global_position, path[0]):
			path.remove(0)
			print(path)
	
func move_toward(orig : float, target : float, amount : float) -> float:
	var result : float

	if abs(orig - target) <= amount:
		result = target
	elif orig < target:
		result = min(orig + amount, target)
	elif orig > target:
		result = max(orig - amount, target)
	return result
	
			
func are_close(p1, p2):
	var res_x = p2.x - p1.x
	var res_y = p2.y - p1.y
	
	if res_x < 10 and res_y < 10:
		print("was close enough")
		return true
	
	return false

#func assign_seat(arg_path):
func assign_seat(point):
#	path = arg_path
#	target = path[1]
#	print("received path", path)
	global_position = point

func leave():
	get_parent().leaving_seat_in_point(global_position)
	global_position = Vector2(global_position.x - 30, global_position.y)
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()

# -------------- Food functionalities --------------
	
func generate_order():
	randomize()
	var index = randi() % order_list.size()
	return order_list[index]

func get_order():
	return order

func try_to_receive_meal(meal):
	if correct_meal(meal):
		receive_meal(meal)
		eat()
	else:
		print("wrong meal!")

func correct_meal(meal):
	return meal.name == order

func receive_meal(meal):
	received_order = meal
	print("received ", received_order)
	
	received_order_sprite = Sprite.new()
	received_order_sprite.set_texture(load(meal.path))
	add_child(received_order_sprite)
	received_order_sprite.position = Vector2($AnimatedSprite.position.x, $AnimatedSprite.position.y + 7)
	player.drop_carried_item()

func eat():
	yield(get_tree().create_timer(5.0), "timeout")
	remove_child(received_order_sprite)
	received_order = null
	leave()
