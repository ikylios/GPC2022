extends Node

var interactableObject = null
var new_customers
var customers
var free_seats
var taken_seats

func _ready():
	new_customers = get_tree().get_nodes_in_group("new_customers")
	free_seats = get_tree().get_nodes_in_group("free_seats")


func _process(_delta):
	if !new_customers.empty():
		seat_customer()
	
	if interactableObject != null:
		if Input.is_action_just_pressed("interact"):
			interactableObject.interact()


# -------------- Customer functionalities --------------

func seat_customer():
	if free_seats.empty():
		return
	
	var free_seat = free_seats.pop_front()
	var customer = new_customers.pop_front()
	
	customer.assign_seat(free_seat.global_position)
	
	# adds the new customer to group customer, as they are now being serviced
	customer.add_to_group("customers")
	# sets local variable customers, if variable customers has not yet been set
	if !customers: customers = get_tree().get_nodes_in_group("customers")
	
	# adds the free seat to group taken_seat, as the seat is not available anymore
	free_seat.add_to_group("taken_seats")
	# sets local variable taken_seats, if variable taken_seats has not yet been set
	if !taken_seats: taken_seats = get_tree().get_nodes_in_group("taken_seats")
	
	


func _on_Ghost_NPC_customer_area_entered(area):
	interactableObject = get_node(area.name)

func _on_Ghost_NPC_customer_area_exited():
	interactableObject = null
