extends Area2D
 
var interactable: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_Interaction_area_body_entered")
	connect("body_exited", self, "_on_Interaction_area_body_exited")

func _process(delta):
	if Input.is_action_pressed("interact"):
		interact()

func interact():
	pass

func _on_Interaction_area_body_entered(body):
	interactable = true

func _on_Interaction_area_body_exited(body):
	interactable = false
