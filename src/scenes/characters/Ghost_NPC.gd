extends "res://scenes/utils/Interactable.gd"

var order
var order_list = ["Spydäri", "Ranskikset", "English Breakfast", "Cucumber_Salad", "Tomato_Salad", "Basic_Burger", "Deluxe_Burger", "Bread"]
var received_order = null
var received_order_sprite
var player
var spawn_area = [Vector2(611, 210), Vector2(742, 295)]

func _ready():
	order = generate_order()
	$AnimatedSprite.play("idle")

func _process(_delta):
	$AnimatedSprite.playing = interactable


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

func assign_seat(point):
	global_position = point

func leave():
	yield(get_tree().create_timer(1.0), "timeout")
	get_node("/root/Main/Restaurant").leaving_seat_in_point(self, global_position)

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
		$Order_bubble.display_wrong()

func correct_meal(meal):
	return meal.name == order

func receive_meal(meal):
	received_order = meal
	
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
