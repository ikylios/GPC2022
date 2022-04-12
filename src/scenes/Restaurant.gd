extends Node2D

var customers_for_the_day
var customers_to_serve
signal end_day


func _process(delta):
	if get_tree().get_nodes_in_group("new_customers").size() > 0 and Input.is_action_just_pressed("ui_accept"):
		print("seating a customer")
		seat_customer()
		
	if Input.is_action_just_pressed("ui_cancel"):
		var cust = $Ghost_NPC
	
		var path = generate_path_to_seat(cust.global_position, $Stool.global_position)
		modify_curve(path)
		
		$Path2D/PathFollow2D.add_child(cust)
		print($Path2D/PathFollow2D.get_child(0))
		
		
	if Input.is_action_just_pressed("ui_home"):
		$Path2D/PathFollow2D.execute_movement()


func start_day():
	customers_for_the_day = generate_customers()
	customers_to_serve = customers_for_the_day.size()
	#create_path2d()
	$Line2D.points = $Path2D.curve.get_baked_points()
	print("customers generated: ", customers_for_the_day)
	print("press ENTER to seat a customer")
	print("press ESC to generate path to seat")
	print("press HOME to execute_movement()")

# --------------- Pathing functionalities -----------------

func create_path2d():
	var path = Path2D.new()
	var path_follow = PathFollow2D.new()
	path.add_child(path_follow)
	add_child(path)
	
func modify_curve(path):
	#print("current path2d ", $Path2D.curve.get_baked_points())
	var new_curve = Curve2D.new()
	for point in path:
		new_curve.add_point(point, Vector2.ZERO, Vector2.ZERO)
	
	#$Line2D.points = new_curve.get_baked_points()
	#print("new curve ", new_curve.get_baked_points())
	$Path2D.curve = new_curve
	$Line2D.points = $Path2D.curve.get_baked_points()
	#$Path2D/PathFollow2D.draw_path()
	#print("path2d new curve ", $Path2D.curve.get_baked_points())
	
#func add_follower_to_path(follower):
#	$Path2D/PathFollow2D.add_child(follower)

func generate_path_to_seat(start, end):
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
	
	customer.assign_seat(free_seat.global_position)
	#var path = generate_path_to_seat(customer.global_position, free_seat.global_position)
	#path_to_curve(path)
	#add_follower_to_path(customer)
	#customer.assign_seat(path)
	
	customer.add_to_group("customers")
	customer.remove_from_group("new_customers")
	
	free_seat.add_to_group("taken_seats")
	free_seat.remove_from_group("free_seats")
	

func leaving_seat_in_point(point):
	update_customer_count()
	for seat in get_tree().get_nodes_in_group("taken_seats"):
		if seat.position == point:
			#print("found the seat")
			seat.remove_from_group("taken_seats")
			seat.add_to_group("free_seats")
			#print("free_seats", get_tree().get_nodes_in_group("free_seats"))

func update_customer_count():
	customers_to_serve -= 1
	if customers_to_serve == 0:
		emit_signal("end_day")

func fetch_customer_types():
	var customer_types = [
		preload("res://scenes/characters/Ghost_NPC.tscn")
	]
	return customer_types
