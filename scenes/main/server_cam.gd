extends Camera2D

var zoom_speed = 0.05
var move_speed = 5

func _process(delta):
	if Input.is_action_pressed("ui_down"):
		zoom.x += zoom_speed
		zoom.y += zoom_speed
	if Input.is_action_pressed("ui_up"):
		zoom.x -= zoom_speed
		zoom.y -= zoom_speed
		
	if Input.is_action_pressed("up"):
		position.y -= move_speed
	if Input.is_action_pressed("down"):
		position.y += move_speed
	if Input.is_action_pressed("left"):
		position.x -= move_speed
	if Input.is_action_pressed("right"):
		position.x += move_speed
