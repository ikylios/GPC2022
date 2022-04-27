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
	#$Ingredients_menu.hide()
	$Popup.hide()
	interactable = false

func init_ingredients_menu():
#	menu = $Ingredients_menu
	menu = $Popup/Panel/ItemList
	
	var ingredients = get_node("/root/Main/Food_index").get_ingredients_list()
	
	var index = 0
	for item in ingredients:
		var item_texture = load(item.path)
		#menu.add_icon_item(item_texture, "", index)
		menu.add_icon_item(item_texture, true)
		path_dict[index] = [item.path, item.name]
		index += 1
	
	menu.rect_position = position
	#menu.rect_position = get_node("/root/Main/Restaurant/Ysort/Player/Camera2D").get_
	#menu.connect("item_rmb_selected", self, "_on_id_pressed")
	#menu.connect("item_rmb_selected", self, "_on_id_pressed")
	
func show_ingredients_menu():
	#$Ingredients_menu.popup()
	$Popup.popup()

#func _on_id_pressed(id):
#	print("id was pressed")
#	var path = path_dict[id][0]
#	var name = path_dict[id][1]

#	emit_signal("get_ingredient", {"path": path, "name": name})


func _on_ItemList_item_activated(index):
	var path = path_dict[index][0]
	var name = path_dict[index][1]
	$Popup.hide()

	emit_signal("get_ingredient", {"path": path, "name": name})
