extends Area2D

var interactable: bool = false

func _ready():
	connect("body_entered", self, "_on_Interaction_area_body_entered")
	connect("body_exited", self, "_on_Interaction_area_body_exited")

func _process(delta):
	if Input.is_action_just_pressed("interact") and interactable:
		interact()

func interact():
	pass

func _on_Interaction_area_body_entered(body):
	print("entered", body)
	print("interacting area of ", self)
	interactable = true

func _on_Interaction_area_body_exited(body):
	interactable = false
