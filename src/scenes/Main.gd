extends Node

var interactableObject = null
var new_customers

func _ready():
	new_customers = get_tree().get_nodes_in_group("new_customers")


func _process(_delta):
	#if new_customers.size() > 0:
	if Input.is_action_just_pressed("ui_accept"):
		print("new customer detected")
		seat_customer()
	
	if interactableObject != null:
		if Input.is_action_just_pressed("interact"):
#			print("interacting with ", interactableObject.name)
			interactableObject.interact()


# -------------- Customer functionalities --------------

func seat_customer():
	var free_seats = get_tree().get_nodes_in_group("free_seats")
	print("free seats", free_seats)
	print("new customers", new_customers)
	
	var customer = new_customers[0]
	var seat = free_seats[0]
	
	var path = generate_path_to_seat(customer.global_position, seat.global_position)
	customer.navigate_to_seat(path)
	
	#new_customers.remove[0]
	#free_seats.remove[0]
	#print("after seating")
	#print("free seats", free_seats)
	#print("new customers", new_customers)
	

func generate_path_to_seat(start, end):
	print("generating path from ", start)
	print("to ", end)
	var path = $Navigation2D.get_simple_path(start, end, false)
	return path


func _on_Ghost_NPC_customer_area_entered(area):
	interactableObject = get_node(area.name)
#	be inspired by the following if overlapping areas are a problem
#	interactableObject = get_node(area.get_overlapping_areas()[0].name)


func _on_Ghost_NPC_customer_area_exited():
	interactableObject = null
