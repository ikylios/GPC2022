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
		output = handle_missing_fields(output)
		return output
	else:
		return {}

func handle_missing_fields(food_dict):
	var food_dict_sections = ["meals", "wip_meals", "ingredients", "menu_visible_ingredients"]
	var must_have_fields = ["bakeable", "cuttable", "fryable"]
	for section in food_dict_sections:
		for item in food_dict.get(section):
			for field in must_have_fields:
				if !item.has(field):
					item[field] = false
	return food_dict

# -------------- Getters -----------------

func get_ingredients_list():
	return food_file.ingredients

func get_menu_visible_ingredients():
	return food_file.menu_visible_ingredients
	
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
	
func get_wip_meal(wip_name):
	for item in food_file.wip_meals:
		if item.name == wip_name:
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
	
	
func try_to_bake(item):
	var baked_item = null
		
	if is_bakeable(item):
		var baked_item_name = get_wip_meal(item).baked_item_name
		baked_item = get_meal(baked_item_name)
	
	return baked_item


func is_cuttable(item):
	if get_ingredient(item) == null:
		return false
	else:
		return get_ingredient(item).cuttable
	
func is_fryable(item):
	if get_ingredient(item) == null:
		return false
	else:
		return get_ingredient(item).fryable
	
func is_bakeable(item):
	var was_a_wip = get_wip_meal(item)
	if was_a_wip == null:
		return false
	else:
		return get_wip_meal(item).bakeable



func try_to_cook(ingredients):
	# checks if either of ingredients is actually a meal. 
	# if yes, removes the meal from ingredients 
	# and adds the ingredients of the meal to the array instead
	for elem in ingredients:
		var was_a_wip = get_wip_meal(elem)
		var was_a_meal = get_meal(elem)
		
		if was_a_wip:
			ingredients.remove(elem)
			for i in was_a_wip.ingredients:
				ingredients.append(i)
				
		if was_a_meal:
			ingredients.remove(elem)
			for i in was_a_meal.ingredients:
				ingredients.append(i)
		
	ingredients.sort()
	
	
	var result = null
	for meal in food_file.meals:
		var meal_ings = meal.ingredients
		meal_ings.sort()
		if meal_ings  == ingredients:
			result = { "name": meal.name, "path": meal.path }
			
	for meal in food_file.wip_meals:
		var meal_ings = meal.ingredients
		meal_ings.sort()
		if meal_ings  == ingredients:
			result = { "name": meal.name, "path": meal.path }
	
	if !result:
		print("didn't find a meal with those ingredients")
	
	return result
