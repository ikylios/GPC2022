extends Area2D


var interactable = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(_delta):
	#$AnimatedSprite.playing = interactable
	# some simple animation here
	print(get_overlapping_areas())
	print(get_overlapping_bodies())

