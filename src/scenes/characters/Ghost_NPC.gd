extends "res://scenes/Interactable.gd"

var order
var order_list = ["spydäri", "ranskikset"]
var received_order = null
var received_order_sprite

func _ready():
	order = generate_order()
	$AnimatedSprite.play("idle")
	add_to_group("new_customers")


func _process(_delta):
	$AnimatedSprite.playing = interactable
	

# -------------- Interaction --------------

func correct_meal(meal):
	return meal.name == order

func waiting_on_meal():
	return self in get_tree().get_nodes_in_group("customers")

func interact():
	var player = get_parent().get_node("Player")
	var meal = player.get_carried_item()
	
	if waiting_on_meal() and meal:
		if correct_meal(meal):
			player.drop_carried_item()
			receive_meal(meal)
		else:
			print("wrong meal!")
	elif !received_order:
		$Order_bubble.display_order(order)
	
	
# -------------- Moving functionalities --------------

func assign_seat(point):
	global_position = point


# -------------- Food functionalities --------------
	
func generate_order():
	randomize()
	var index = randi() % order_list.size()
	return order_list[index]

func get_order():
	return order

func receive_meal(meal):
	received_order = meal
	print("received ", received_order)
	
	received_order_sprite = Sprite.new()
	received_order_sprite.set_texture(load(meal.path))
	add_child(received_order_sprite)
	received_order_sprite.position = Vector2($AnimatedSprite.position.x, $AnimatedSprite.position.y + 7)
