extends Node

var customers_for_the_day

func _ready():
	customers_for_the_day = generate_customers()
	print("customers generated: ", customers_for_the_day)
	print("press ENTER to seat a customer")


func _process(_delta):
	if get_tree().get_nodes_in_group("new_customers").size() > 0 and Input.is_action_just_pressed("ui_accept"):
		print("seating a customer")
		seat_customer()
	if Input.is_action_just_pressed("ui_pause"):
		get_tree().paused = true
		var x_pos = get_viewport().get_visible_rect().size.x / 2
		var y_pos = get_viewport().get_visible_rect().size.y / 2


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
	print(get_tree().get_nodes_in_group("free_seats"))
	if !get_tree().get_nodes_in_group("free_seats"):
		print("no more free seats available")
		return
	
	var free_seat = get_tree().get_nodes_in_group("free_seats").pop_front()
	var customer = get_tree().get_nodes_in_group("new_customers").pop_front()
	
	customer.assign_seat(free_seat.global_position)
	
	customer.add_to_group("customers")
	customer.remove_from_group("new_customers")
	
	free_seat.add_to_group("taken_seats")
	free_seat.remove_from_group("free_seats")

func leaving_seat_in_point(point):
	for seat in get_tree().get_nodes_in_group("taken_seats"):
		if seat.position == point:
			print("found the seat")
			seat.remove_from_group("taken_seats")
			seat.add_to_group("free_seats")
			print("free_seats", get_tree().get_nodes_in_group("free_seats"))

func fetch_customer_types():
	var customer_types = [
		preload("res://scenes/characters/Ghost_NPC.tscn")
	]
	return customer_types
