extends Node2D

func _ready():
	pass

func _process(delta):
	handle_keyboard()
	handle_mouse()
	
func handle_keyboard():
	if Input.is_anything_pressed():
		var scene_field = load("res://Scene/field.tscn").instantiate()
		scene_field.name = "Field"
		get_tree().root.add_child(scene_field, true)
		queue_free()
	
func handle_mouse():
	pass
