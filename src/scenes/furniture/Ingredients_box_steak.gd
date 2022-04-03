extends "res://scenes/Interactable.gd"

var ingredient_type = "Steak"
signal get_ingredient


func _ready():
	var player = get_parent().get_node("Player")
	connect("get_ingredient", player, "_on_Ingredient_box_interacted")


func interact():
	var path = "res://assets/food/ingredients/Steak.png"
	
	#match ingredient_type:
	#	"Potato": path += "Potato.png"
	#	"Steak": path = "Steak.png"
	
	print("path from source:", path)
	
	emit_signal("get_ingredient", {"path": path, "name": ingredient_type})
