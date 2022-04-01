extends "res://scenes/Interactable.gd"

var ingredient_type = "potato"
signal get_ingredient


func _ready():
	var player = get_parent().get_node("Player")
	connect("get_ingredient", player, "_on_Ingredient_box_interacted")


func interact():
	var path = "res://assets/food/ingredients/"
	match ingredient_type:
		"potato": path += "Potato.png"
		"steak": path = "Steak.png"
	emit_signal("get_ingredient", path, ingredient_type)
