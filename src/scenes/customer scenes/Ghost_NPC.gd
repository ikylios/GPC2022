extends KinematicBody2D

var speed = 200 # How fast the customer will move (pixels/sec).
var order
var interactable = false
signal customer_area_entered
signal customer_area_exited

var order_list = ["spydäri", "ranskikset"]



func _ready():
	order = generate_order()
#	print("generated order ", order)
	$AnimatedSprite.play("idle")


func _process(_delta):
	$AnimatedSprite.playing = interactable
	$Line2D.global_position = Vector2.ZERO


	
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


# -------------- Interaction --------------

func interact():
	$Order_bubble.display_order(order)

func _on_Interaction_Area_body_entered(body):
	emit_signal("customer_area_entered", self)
	interactable = true

func _on_Interaction_Area_body_exited(body):
	emit_signal("customer_area_exited")
	interactable = false
