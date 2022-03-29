extends Area2D

var interactable = false
var type
signal picked_up

# Called when the node enters the scene tree for the first time.
func _ready():
	var collisionShape = CollisionShape2D.new()
	var circleShape = CircleShape2D.new()
	circleShape.set_radius(10)
	collisionShape.set_shape(circleShape)
	add_child(collisionShape)
	
	connect("body_entered", self, "_on_Ingredient_body_entered")
	connect("body_exited", self, "_on_Ingredient_body_exited")
	var player = get_parent().get_node("Player")
	connect("picked_up", player, "_on_Ingredient_picked_up")

func init(type, position):
	self.type = type
	self.position = position
	
	var texture
	
	match type:
		"potato": texture = preload("res://assets/ingredients/Potato.png")
		"steak": texture = preload("res://assets/ingredients/Steak.png")
	
	$ingredient_sprite.set_texture(texture)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_E:
			try_interact()

func _process(_delta):
	pass
	
func _on_Ingredient_body_entered(body):
	interactable = true

func _on_Ingredient_body_exited(body):
	interactable = false

func try_interact():
	if interactable:
		emit_signal("picked_up", type)
		visible = not visible


