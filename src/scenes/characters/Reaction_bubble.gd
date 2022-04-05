extends Control

var name_to_texture = {
	"spydäri": "res://assets/food/meals/68_macncheese_dish.png",
	"ranskikset": "res://assets/food/meals/45_frenchfries_dish.png"
}

func _ready():
	self.visible = false
	
func meal_name_to_file_path(order):
	return name_to_texture[order]

func display_order(order):
	$bg/image.texture = load(meal_name_to_file_path(order))
	self.visible = true
	yield(get_tree().create_timer(3.0), "timeout")
	self.visible = false
