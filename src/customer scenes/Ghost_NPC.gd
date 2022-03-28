extends Area2D

var speed = 200 # How fast the player will move (pixels/sec).
var screen_size
var order
var interactable = false
var rng = RandomNumberGenerator.new()

var order_list = ["spydäri", "ranskikset"]

func _ready():
	screen_size = get_viewport_rect().size
	order = generate_order()
	print("generated order ", order)
	$AnimatedSprite.play("idle")
	

func _process(_delta):
	$AnimatedSprite.playing = interactable
	
func generate_order():
	rng.randomize()
	var index = rng.randi_range(0, 1)
	print(index)
	return order_list[index]

func get_order():
	return order

func interact():
	$Order_bubble.display_order(order)

func _on_Ghost_NPC_body_entered(body):
	interactable = true

func _on_Ghost_NPC_body_exited(body):
	interactable = false
