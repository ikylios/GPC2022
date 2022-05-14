extends Node2D

var customers_for_the_day = []
var customers_to_serve

signal end_day


func _process(delta):
	if Input.is_action_just_pressed("ui_home"):
		if customers_for_the_day.size() > 0:
			enter_restaurant()
		else: print("Can't invite in more customers; all customers have been served for the day!")

	if Input.is_action_just_pressed("ui_pause"):
		print("Paused game")
		show_pause_menu()


func start_day():
	generate_customers()
	customers_to_serve = customers_for_the_day.size()
	print("Generated amount of customers: ", customers_for_the_day.size())
	enter_restaurant()
	
func show_pause_menu():
	get_tree().paused = true
	$Pause_popup.set_position($YSort/Player/Camera2D.get_camera_screen_center())
	$Pause_popup.show()

# --------------- Pathing functionalities -----------------

func create_walkable_path():
	var path2D = load("res://scenes/utils/Walkable_path.tscn").instance()
	add_child(path2D)
	path2D.add_to_group("paths")

func move_customer(customer, target_point):
	create_walkable_path()
	var path = generate_path_to_point(customer.global_position, target_point)
	var curve = path_to_curve(path)
	var path2D = get_tree().get_nodes_in_group("paths").pop_front()
	path2D.remove_from_group("paths")
	path2D.curve = curve
	path2D.get_node("Walkable_path_follow").set_node_to_remote_transform(customer)

func path_to_curve(path):
	var new_curve = Curve2D.new()
	for point in path:
		new_curve.add_point(point, Vector2.ZERO, Vector2.ZERO)
	return new_curve

func generate_path_to_point(start, end):
	var path = $Navigation2D.get_simple_path(start, end, false)
	return path


# -------------- Customer functionalities --------------

func generate_customers():
	var customer_types = fetch_customer_types()
	randomize()
	var number_of_customers = (randi() % 4) + 2

	for i in number_of_customers:
		var customer = customer_types[randi() % customer_types.size()-1]
		customers_for_the_day.append(customer)
	
func customer_arrival():
	yield(get_tree().create_timer(0.5), "timeout")
	if customers_for_the_day.size() > 0:
		
		if get_tree().get_nodes_in_group("customers").size() >= 1:
			enter_restaurant()


func seat_customer():
	var free_seat = get_tree().get_nodes_in_group("free_seats").pop_front()
	var customer = get_tree().get_nodes_in_group("new_customers").pop_front()
	
	move_customer(customer, free_seat.global_position)
	
	customer.add_to_group("customers")
	customer.remove_from_group("new_customers")
	
	free_seat.add_to_group("taken_seats")
	free_seat.remove_from_group("free_seats")


func enter_restaurant():
	var customer = customers_for_the_day.pop_front()
	var customer_as_instance = customer.instance()
	customer_as_instance.add_to_group("entering_customers")
	
	$YSort.add_child(customer_as_instance)
	
	customer_as_instance.global_position = $Exit_door.global_position
	var goal = Vector2($Exit_door.global_position.x, $Exit_door.global_position.y + 50)
	
	move_customer(customer_as_instance, goal)
	
	
func _on_finished_moving():
	if get_tree().get_nodes_in_group("entering_customers"):
		if get_tree().get_nodes_in_group("free_seats").size() > 0:
			var customer = get_tree().get_nodes_in_group("entering_customers").pop_front()
			customer.add_to_group("new_customers")
			customer.remove_from_group("entering_customers")
			yield(get_tree().create_timer(0.3), "timeout")
			seat_customer()
		else:
			print("No free seats!")
	

func leaving_seat_in_point(customer, point):
	for seat in get_tree().get_nodes_in_group("taken_seats"):
		if seat.position == point:
			move_customer(customer, $Exit_door.global_position)
			seat.remove_from_group("taken_seats")
			seat.add_to_group("free_seats")
			update_customer_count()
			customer_arrival()

func update_customer_count():
	customers_to_serve -= 1
	if customers_to_serve == 0:
		yield(get_tree().create_timer(1.5), "timeout")
		emit_signal("end_day")

func fetch_customer_types():
	var customer_types = [
		preload("res://scenes/characters/Ghost_NPC.tscn")
	]
	return customer_types
