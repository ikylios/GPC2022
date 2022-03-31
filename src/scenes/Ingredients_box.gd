extends Area2D

var interactable = false
var ingredient_type = "potato"
signal get_ingredient

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_Ingredient_box_body_entered")
	connect("body_exited", self, "_on_Ingredient_box_body_exited")
	var player = get_parent().get_node("Player")
	connect("get_ingredient", player, "_on_Ingredient_box_interacted")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_E:
			try_interact()

func _on_Ingredient_box_body_entered(body):
	interactable = true

func _on_Ingredient_box_body_exited(body):
	interactable = false

func try_interact():
	if interactable:
		emit_signal("get_ingredient", ingredient_type)
