extends Area2D

var speed = 200 # How fast the player will move (pixels/sec).
var screen_size
var order
var interactable = false
signal customer_area_entered
signal customer_area_exited

var order_list = ["spydäri", "ranskikset"]

func _ready():
	screen_size = get_viewport_rect().size
	order = generate_order()
#	print("generated order ", order)
	$AnimatedSprite.play("idle")
	

func _process(_delta):
	$AnimatedSprite.playing = interactable
	
func generate_order():
	randomize()
	var index = randi() % order_list.size()
	return order_list[index]

func get_order():
	return order

func interact():
	$Order_bubble.display_order(order)

func _on_Ghost_NPC_body_entered(body):
	emit_signal("customer_area_entered", self)
	interactable = true

func _on_Ghost_NPC_body_exited(body):
	emit_signal("customer_area_exited")
	interactable = false

