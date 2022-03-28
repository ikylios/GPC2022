extends Area2D

var speed = 200 # How fast the player will move (pixels/sec).
var screen_size
var order
var interactable = false

var order_list = ["spydäri"]

func _ready():
	screen_size = get_viewport_rect().size
	order = generate_order()
	$AnimatedSprite.play("idle")
	

func _process(_delta):
	$AnimatedSprite.playing = interactable
	
func generate_order():
	return order_list[0]

func _on_Ghost_NPC_body_entered(body):
	interactable = true

func _on_Ghost_NPC_body_exited(body):
	interactable = false
