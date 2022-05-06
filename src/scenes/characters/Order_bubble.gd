extends Control

var name_to_texture = {
	"Spydäri": "res://assets/food/meals/68_macncheese_dish.png",
	"Ranskikset": "res://assets/food/meals/45_frenchfries_dish.png"
}

func _ready():
	self.visible = false
	$bg/meal_icon.texture = null
	
func meal_name_to_file_path(order):
	return name_to_texture[order]

func display_order(order):
	$bg/meal_icon.texture = load(meal_name_to_file_path(order))
	self.visible = true
	$Timer.start()

func _on_Timer_timeout():
	self.visible = false

