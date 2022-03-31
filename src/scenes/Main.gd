extends Node

var screen_size_x
var screen_size_y
onready var interactableObject = null

func _ready():
	screen_size_x = get_viewport().size.x
	screen_size_y = get_viewport().size.y
	 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
