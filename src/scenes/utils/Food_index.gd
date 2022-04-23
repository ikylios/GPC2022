extends Node

var food_index_file_path = "res://assets/foods.json"
var food_file

func _ready():
	food_file = load_foods()


func load_foods() -> Dictionary:
	var file = File.new()
	assert(file.file_exists(food_index_file_path), "File according to path does not exist.")
	
	file.open(food_index_file_path, File.READ)
	var json = file.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_DICTIONARY:
		return output
	else:
		return {}

# -------------- Getters -----------------

func get_ingredients_list():
	return food_file.ingredients

func get_menu_visible_ingredients():
	return food_file.menu_visible_ingredients
	
func get_meals_list():
	return food_file.meals

func get_meal(meal_name):
	for item in food_file.meal:
		if item.name == meal_name:
			return item
	return null
	
func get_ingredient(ingredient_name):
	for item in food_file.ingredients:
		if item.name == ingredient_name:
			return item
	return null


# -------------- Kitchen tool checks -----------------
	
func try_to_chop(item):
	var cut_item = null
	
	if is_cuttable(item):
		var cut_item_name = get_ingredient(item).cut_ingredient_name
		cut_item = get_ingredient(cut_item_name)
	
	return cut_item

func try_to_fry(item):
	var fried_item = null
		
	if is_fryable(item):
		var fried_item_name = get_ingredient(item).fried_ingredient_name
		fried_item = get_ingredient(fried_item_name)
	
	return fried_item

func is_cuttable(item):
	return get_ingredient(item).cuttable
	
func is_fryable(item):
	return get_ingredient(item).fryable


func try_to_cook(ingredients):
	var meals = food_file.meals
	
	ingredients.sort()
	var result = null
	for meal in meals:
		if meal.ingredients == ingredients:
			result = { "name": meal.name, "path": meal.path }
	
	if !result:
		print("didn't find a meal with those ingredients")
	
	return result
