extends "res://scenes/utils/Interactable.gd"

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
	$Popup.hide()
	interactable = false

func init_ingredients_menu():
	menu = $Popup/ItemList
	
	var ingredients = get_node("/root/Main/Food_index").get_menu_visible_ingredients()
	
	var index = 0
	for item in ingredients:
		var item_texture = load(item.path)
		menu.add_icon_item(item_texture, true)
		path_dict[index] = [item.path, item.name]
		index += 1
	
	menu.rect_position = position
	#menu.rect_position = get_node("/root/Main/Restaurant/Ysort/Player/Camera2D").get_
	
func show_ingredients_menu():
	$Popup.show()

func _on_ItemList_item_activated(index):
	var path = path_dict[index][0]
	var name = path_dict[index][1]
	$Popup.hide()

	emit_signal("get_ingredient", {"path": path, "name": name})
