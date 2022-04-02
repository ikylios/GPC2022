extends "res://scenes/Interactable.gd"

var order
var order_list = ["spydäri", "ranskikset"]

func _ready():
	order = generate_order()
	$AnimatedSprite.play("idle")
	add_to_group("new_customers")


func _process(_delta):
	$AnimatedSprite.playing = interactable
	

# -------------- Interaction --------------

func interact():
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
