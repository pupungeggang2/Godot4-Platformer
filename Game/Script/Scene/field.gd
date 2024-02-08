extends Node2D

@onready var node_player = get_node("Player")
@onready var node_thing = get_node("Thing")

func _ready():
	node_player.position = Vector2(240, 40)
	var temp_thing = load("res://Scene/Instance/wall.tscn").instantiate()
	temp_thing.rect = [0, 0, 80, 160]
	temp_thing.position = Vector2(temp_thing.rect[0], temp_thing.rect[1])
	temp_thing.get_node("Rect").size = Vector2(temp_thing.rect[2], temp_thing.rect[3])
	node_thing.add_child(temp_thing)
	
	temp_thing = load("res://Scene/Instance/wall.tscn").instantiate()
	temp_thing.rect = [400, 0, 80, 160]
	temp_thing.position = Vector2(temp_thing.rect[0], temp_thing.rect[1])
	temp_thing.get_node("Rect").size = Vector2(temp_thing.rect[2], temp_thing.rect[3])
	node_thing.add_child(temp_thing)

func _process(delta):
	player_move(delta)
	handle_keyboard()
	handle_mouse()
	
func player_move(delta):
	var position_temp = node_player.position
	# handle x
	if Var.input.pressed.left == true:
		position_temp.x += -node_player.speed * delta
	elif Var.input.pressed.right == true:
		position_temp.x += node_player.speed * delta
		
	# handle y
	
	# handle collision
	for thing in node_thing.get_children():
		if thing.type == 'wall':
			var left = thing.rect[0]
			var right = thing.rect[0] + thing.rect[2]
			var up = thing.rect[1]
			var down = thing.rect[1] + thing.rect[3]
			
			if position_temp.x > left - 20 and position_temp.x < left + 20 and position_temp.y > up - 20 and position_temp.y < down + 20:
				var overlapped = position_temp.x + 20 - left
				position_temp.x -= overlapped
				
			if position_temp.x > right - 20 and position_temp.x < right + 20 and position_temp.y > up - 20 and position_temp.y < down + 20:
				var overlapped = right - position_temp.x + 20
				position_temp.x += overlapped
	
	node_player.position = position_temp
	
func handle_keyboard():
	if Input.is_action_just_pressed("key_left"):
		Var.input.pressed.left = true
	if Input.is_action_just_pressed("key_right"):
		Var.input.pressed.right = true
	if Input.is_action_just_pressed("key_up"):
		Var.input.pressed.up = true
	if Input.is_action_just_pressed("key_down"):
		Var.input.pressed.down = true
	if Input.is_action_just_pressed("key_dash"):
		Var.input.pressed.dash = true
	if Input.is_action_just_pressed("key_jump")	:
		Var.input.pressed.jump = true
		
	if Input.is_action_just_released("key_left"):
		Var.input.pressed.left = false
	if Input.is_action_just_released("key_right"):
		Var.input.pressed.right = false
	if Input.is_action_just_released("key_up"):
		Var.input.pressed.up = false
	if Input.is_action_just_released("key_down"):
		Var.input.pressed.down = false
	if Input.is_action_just_released("key_dash"):
		Var.input.pressed.dash = false
	if Input.is_action_just_released("key_jump"):
		Var.input.pressed.jump = false
		
func handle_mouse():
	pass
