extends Area2D


func _ready():
	#connect("npc_area_entered", get_parent(), "_on_NPC_area_entered")
	#connect("npc_area_exited", get_parent(), "_on_NPC_area_exited")
	add_to_group("free_seats")

