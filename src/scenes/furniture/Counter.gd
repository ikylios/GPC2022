extends "res://scenes/Interactable.gd"

var item = null
var item_sprite = null

func interact():
	var player = get_parent().get_node("Player")
	var player_item = player.get_carried_item()
	
	if player_item and !item:
		item = player_item
		player.drop_carried_item()
		set_item_sprite()
	
	elif !player_item and item:
		player.set_carried_item(item)
		item = null
		remove_child(item_sprite)
		
	elif player_item and item:
		var meal = null
		meal = try_to_cook([item.name, player_item.name])
		if meal:
			player.drop_carried_item()
			item = meal
			item_sprite.set_texture(load(item.path))


func set_item_sprite():
	item_sprite = Sprite.new()
	add_child(item_sprite)
	item_sprite.set_texture(load(item.path))
	item_sprite.position = Vector2($Sprite.position.x, $Sprite.position.y - 7)
	

func try_to_cook(ingredients):
	var meals = [ 
		{ "name": "spydäri", "path": "res://assets/food/meals/68_macncheese_dish.png", "ingredients": ["Potato", "Steak"] },
		{ "name": "ranskikset", "path": "res://assets/food/meals/45_frenchfries_dish.png", "ingredients": ["Potato", "Potato"] }
	]
	
	ingredients.sort()
	var result = null
	for meal in meals:
		print("meal.ingredients: ", meal.ingredients)
		print("ingredients: ", ingredients)
		if meal.ingredients == ingredients:
			print("found a meal")
			result = { "name": meal.name, "path": meal.path }
	
	if !result:
		print("didn't find a meal with those ingredients")
	
	return result
