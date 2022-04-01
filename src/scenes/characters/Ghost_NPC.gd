extends KinematicBody2D

var order
var interactable = false
signal npc_area_entered
signal npc_area_exited

var order_list = ["spydäri", "ranskikset"]


func _ready():
	order = generate_order()
	$AnimatedSprite.play("idle")

	connect("npc_area_entered", get_parent(), "_on_NPC_area_entered")
	connect("npc_area_exited", get_parent(), "_on_NPC_area_exited")
	add_to_group("new_customers")


func _process(_delta):
	$AnimatedSprite.playing = interactable


	
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
	emit_signal("npc_area_entered", self)
	interactable = true

func _on_Interaction_Area_body_exited(body):
	emit_signal("npc_area_exited")
	interactable = false
