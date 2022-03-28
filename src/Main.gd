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
	if interactableObject != null:
		if Input.is_action_just_pressed("ui_accept"):
			interact()
			
func interact():    
	#$HUD.display_dialog(get_node(interactableObject).get_dialog())
	#pause tässä estää sen, että main aktivoi interact() -metodia samalla kun hud tekee dialogia loppuun
	#get_tree().paused = true
	pass
	

func unpause():
	get_tree().paused = false
	

func add_ingredient(type):
	var potato_texture = preload("res://assets/ingredients/Potato.png")
	var steak_texture = preload("res://assets/ingredients/Steak.png")
	var texture
	match type:
		"potato": texture = potato_texture
		"steak": texture = steak_texture
		
	var ingredient = preload("res://Ingredient.tscn").instance()	
	add_child(ingredient)
	ingredient.get_node("ingredient_sprite").set_texture(texture)
	ingredient.get_node("ingredient_sprite").position = Vector2(screen_size_x-screen_size_x/3, screen_size_y/3)
	var collisionShape = CollisionShape2D.new()
	var circleShape = CircleShape2D.new()
	circleShape.set_radius(10)
	collisionShape.set_shape(circleShape)
	ingredient.add_child(collisionShape)
