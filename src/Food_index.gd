extends Node

var food_index_file_path = "res://assets/foods.json"
var food_file

func _ready():
	food_file = load_foods()


func load_foods() -> Dictionary:
	var file = File.new()
	assert(file.file_exists(food_index_file_path), "File path does not exist.")
	
	file.open(food_index_file_path, File.READ)
	var json = file.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_DICTIONARY:
		return output
	else:
		return {}


func get_ingredients_list():
	return food_file.ingredients
	
func get_meals_list():
	return food_file.meals

func get_meal(meal_name):
	return food_file.meals[meal_name]
	
func get_ingredient(ingredient_name):
	return food_file.ingredients[ingredient_name]


func try_to_cook(ingredients):
	var meals = food_file.meals
	
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
