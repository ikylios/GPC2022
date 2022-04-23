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
	
func get_meals_list():
	return food_file.meals

func get_meal(meal_name):
	for item in food_file.meals:
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

func is_cuttable(item):
	return get_ingredient(item).cuttable



func try_to_cook(ingredients):
	# checks if either of ingredients is actually a meal. if yes, removes the meal from ingredients and adds the ingredients of the meal to the array instead
	for elem in ingredients:
		var was_a_meal = get_meal(elem)
		
		if was_a_meal:
			ingredients.remove(elem)
			for i in was_a_meal.ingredients:
				ingredients.append(i)
		
	ingredients.sort()
	
	
	var result = null
	for meal in food_file.meals:
		var meal_ings = meal.ingredients
		meal_ings.sort()
		print("sorted meal_ings: ", meal_ings)
		if meal_ings  == ingredients:
			result = { "name": meal.name, "path": meal.path }
	
	if !result:
		print("didn't find a meal with those ingredients")
	
	return result
		
