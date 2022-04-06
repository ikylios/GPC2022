extends Control

func _ready():
	self.visible = false
	
func meal_name_to_file_path(order):
	var result = get_parent().get_parent().get_node("Food_index").get_meal(order).path
	return result

func display_order(order):
	$bg/image.texture = load(meal_name_to_file_path(order))
	self.visible = true
	yield(get_tree().create_timer(3.0), "timeout")
	self.visible = false
