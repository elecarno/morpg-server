extends Node2D

var enemy_spawn = preload("res://enemies/server_enemy.tscn")
var player_spawn = preload("res://player/server_player.tscn")

func spawn_enemy(enemy_id, enemy_data, speed):
	var new_enemy = enemy_spawn.instance()
	new_enemy.position = enemy_data["enemy_location"]
	new_enemy.name = str(enemy_id)
	new_enemy.id = enemy_id
	new_enemy.speed = speed
	get_node("enemies").add_child(new_enemy, true)

func spawn_player(player_id, pos):
	var new_player = player_spawn.instance()
	new_player.position = pos
	new_player.name = str(player_id)
	get_node("players").add_child(new_player, true)
