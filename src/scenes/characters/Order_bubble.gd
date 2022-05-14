extends Control

var name_to_texture = {}

func _ready():
	self.visible = false
	set_meals()
	$bg/meal_icon.texture = null

func set_meals():
	var meals = get_node("/root/Main/Food_index").get_meals_list()
	for meal in meals:
		name_to_texture[meal.name] = meal.path

func meal_name_to_file_path(order):
	return name_to_texture[order]

func display_order(order):
	$bg/meal_icon.texture = load(meal_name_to_file_path(order))
	self.visible = true
	$Timer.start()

func display_wrong():
	$bg/meal_icon.texture = load("res://assets/ui/cross.png")
	self.visible = true
	$Timer.start()

func _on_Timer_timeout():
	self.visible = false
