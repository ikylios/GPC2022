extends "res://scenes/Interactable.gd"

var ingredient_type = "Potato"
var menu
var path_dict = {}
signal get_ingredient

func _ready():
	var player = get_parent().get_node("Player")
	connect("get_ingredient", player, "_on_Ingredient_box_interacted")
	init_ingredients_menu()

func interact():
	show_ingredients_menu()

func _on_Interaction_area_body_exited(body):
	._on_Interaction_area_body_exited(body)
	$Ingredients_menu.hide()

func init_ingredients_menu():
	menu = $Ingredients_menu
	var path = "res://assets/food/ingredients/"
	var ingredients = ["Potato.png", "Steak.png", "Egg.png"]
	
	var index = 0
	for item in ingredients:
		var item_texture = load(path + item)
		menu.add_icon_item(item_texture, "", index)
		path_dict[index] = [path + item, item]
		index += 1
	
	print(path_dict)
	menu.rect_position = position
	menu.connect("id_pressed", self, "_on_id_pressed")
	
func show_ingredients_menu():
	$Ingredients_menu.popup()

func _on_id_pressed(id):
	var path = path_dict[id][0]
	var file_name = path_dict[id][1]
	var ingredient_type = get_ingredient_type_from_file_name(file_name)
		
	print(path)
	emit_signal("get_ingredient", {"path": path, "name": ingredient_type})

func get_ingredient_type_from_file_name(file_name):
	var ingredient_type
	match file_name:
		"Potato.png": ingredient_type = "Potato"
		"Steak.png": ingredient_type = "Steak"
		"Egg.png": ingredient_type = "Egg"
	return ingredient_type
