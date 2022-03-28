extends Area2D

var interactable = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var collisionShape = CollisionShape2D.new()
	var circleShape = CircleShape2D.new()
	circleShape.set_radius(10)
	collisionShape.set_shape(circleShape)
	add_child(collisionShape)
	connect("body_entered",self,"_on_Ingredient_body_entered")
	connect("body_exited",self,"_on_Ingredient_body_exited")

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
		print("Interacted!")
	else:
		print("Can't interact")

