extends Node

var interactableObject = null
var new_customers
var customers
var free_seats
var taken_seats
var customers_for_the_day

func _ready():
	customers_for_the_day = generate_customers()
	print("customers generated: ", customers_for_the_day)
	
	new_customers = get_tree().get_nodes_in_group("new_customers")
	free_seats = get_tree().get_nodes_in_group("free_seats")
	print("press ENTER to seat a customer")


func _process(_delta):
	
	if new_customers.size() > 0 and Input.is_action_just_pressed("ui_accept"):
		print("seating a customer")
		seat_customer()
	
	if interactableObject != null:
		if Input.is_action_just_pressed("interact"):
			interactableObject.interact()


# -------------- Customer functionalities --------------

func generate_customers():
	var customer_types = fetch_customer_types()
	randomize()
	var number_of_customers = (randi() % 4) + 2

	var selected_customers = []
	for i in number_of_customers:
		var customer = customer_types[randi() % customer_types.size()-1]
		var customer_as_instance = customer.instance()
		self.add_child(customer_as_instance)
		selected_customers.append(customer_as_instance)

	return selected_customers
	

func seat_customer():
	if free_seats.empty():
		print("no more free seats available")
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

func fetch_customer_types():
	var customer_types = [
		preload("res://scenes/characters/Ghost_NPC.tscn")
	]
	return customer_types


func _on_NPC_area_entered(area):
	interactableObject = get_node(area.name)

func  _on_NPC_area_exited():
	interactableObject = null

