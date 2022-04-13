extends Node2D

var customers_for_the_day
var customers_to_serve

var path_free = true

signal end_day


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if path_free and get_tree().get_nodes_in_group("new_customers").size() > 0:
			path_free = false
			seat_customer()
		else:
			print("path is in use or there are no new customers!")

			if Input.is_action_just_pressed("ui_pause"):
				show_pause_menu()
		
	func show_pause_menu():
		get_tree().paused = true
		var camera = get_node("Player").get_node("Camera2D")
		$Pause_popup_holder/Pause_popup.set_position(Vector2(camera.get_camera_screen_center()))
		$Pause_popup_holder/Pause_popup.show()
		$Player.z_index = 0


func start_day():
	customers_for_the_day = generate_customers()
	print("generated amount of customers, ", customers_for_the_day.size())
	customers_to_serve = customers_for_the_day.size()


# --------------- Pathing functionalities -----------------

func move_customer(customer, target):
	var path = generate_path_to_point(customer.global_position, target.global_position)
	modify_curve(path)
	$Path2D/PathFollow2D.set_node_to_remote_transform(customer)

func modify_curve(path):
	var new_curve = Curve2D.new()
	for point in path:
		new_curve.add_point(point, Vector2.ZERO, Vector2.ZERO)
	$Path2D.curve = new_curve

func generate_path_to_point(start, end):
	var path = $Navigation2D.get_simple_path(start, end, false)
	return path


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
	
	move_customer(customer, free_seat)
	
	customer.add_to_group("customers")
	customer.remove_from_group("new_customers")
	
	free_seat.add_to_group("taken_seats")
	free_seat.remove_from_group("free_seats")
	

func leaving_seat_in_point(customer, point):
	update_customer_count()
	for seat in get_tree().get_nodes_in_group("taken_seats"):
		if seat.position == point:
			move_customer(customer, $Exit_door)
			seat.remove_from_group("taken_seats")
			seat.add_to_group("free_seats")

func update_customer_count():
	customers_to_serve -= 1
	if customers_to_serve == 0:
		emit_signal("end_day")

func fetch_customer_types():
	var customer_types = [
		preload("res://scenes/characters/Ghost_NPC.tscn")
	]
	return customer_types


func _on_PathFollow2D_finished_path():
	path_free = true
