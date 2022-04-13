extends "res://scenes/Interactable.gd"

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
	$Ingredients_menu.hide()
	interactable = false

func init_ingredients_menu():
	menu = $Ingredients_menu
	
	var food_index = get_parent().get_parent().get_node("Food_index")
	print("food_index from ing box ", food_index)
	#get_parent().get_parent().get_node("Food_index").get_ingredients_list()
	#var ingredients = get_parent().get_parent().get_node("Food_index").get_ingredients_list()
	var ingredients = []
	
	var index = 0
	for item in ingredients:
		var item_texture = load(item.path)
		menu.add_icon_item(item_texture, "", index)
		path_dict[index] = [item.path, item.name]
		index += 1
	
	menu.rect_position = position
	menu.connect("id_pressed", self, "_on_id_pressed")
	
func show_ingredients_menu():
	$Ingredients_menu.popup()

func _on_id_pressed(id):
	var path = path_dict[id][0]
	var name = path_dict[id][1]

	emit_signal("get_ingredient", {"path": path, "name": name})
