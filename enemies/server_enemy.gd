extends KinematicBody2D

var direction = 1 # 1 = right, -1 = left
var gravity = 10
var speed = 32
var velocity := Vector2(0, 0)

onready var sprite = get_node("sprite")
onready var attack_timer = get_node("attack_timer")
onready var enemies = get_parent().get_parent().get_parent().get_node("map").enemy_list

var is_attacking := false

var id = 0

func _process(delta):
	update_state()
	
	if enemies[id].enemy_hp <= 0:
		enemies[id].enemy_state = "dead"
		return
		
	if !is_attacking:
		move_character()
	detect_turn_around()
	
func move_character():
	enemies[id].enemy_state = "moving"
	velocity.x = speed * direction
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
func detect_turn_around():
	if get_node("sprite/detect_wall_lower").is_colliding() or get_node("sprite/detect_wall_upper").is_colliding():
		direction *= -1
		sprite.scale.x = direction

func update_state():
	enemies[id].enemy_location = global_position
	enemies[id].enemy_dir = direction

func _on_player_detection_body_entered(body):
	enemies[id].enemy_state = "attacking"
	is_attacking = true
	attack_timer.start()

func _on_attack_timer_timeout():
	is_attacking = false

#func _on_player_detection_body_exited(body):
#	enemies[id].enemy_state = "moving"
#	is_attacking = false
