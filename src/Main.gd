extends Node

var screen_size_x
var screen_size_y
onready var interactableObject = null

func _ready():
	screen_size_x = get_viewport().size.x
	screen_size_y = get_viewport().size.y
	add_ingredient("potato")
	 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_ingredient(type):
	var ingredient = preload("res://Ingredient.tscn").instance()	
	var position = Vector2(screen_size_x-screen_size_x/3, screen_size_y/3)
	ingredient.init(type, position)
	add_child(ingredient)
