extends Control

var temp_order

var name_to_texture = {
	"Spydäri": "res://assets/food/meals/68_macncheese_dish.png",
	"Ranskikset": "res://assets/food/meals/45_frenchfries_dish.png",
	"English_Breakfast": "res://assets/food/meals/English_Breakfast.png",
	"Cucumber_Salad": "res://assets/food/meals/Cucumber_Salad.png",
	"Tomato_Salad": "res://assets/food/meals/Tomato_Salad.png",
	"Basic_Burger": "res://assets/food/meals/45_frenchfries_dish.png",
}

func _ready():
	self.visible = false
	$bg/meal_icon.texture = null
	
func meal_name_to_file_path(order):
	return name_to_texture[order]

func display_order(order):
	var temp_order = order
	$bg/meal_icon.texture = load(meal_name_to_file_path(order))
	self.visible = true
	$Timer.start()
	
func display_wrong():
	$bg/meal_icon.texture = load("res://assets/ui/cross.png")
	self.visible = true
	$Timer.start()

func _on_Timer_timeout():
	self.visible = false
	#$bg/meal_icon.texture = load(meal_name_to_file_path(temp_order))

