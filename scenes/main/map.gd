extends Node2D

var enemy_id_counter = 1
var enemy_max = 10
var enemy_types
var enemy_spawn_points = [Vector2(2752, -55), Vector2(-860, -70), Vector2(-880, -70), Vector2(-900, -70)]
var open_locations = [0, 1, 2, 3]
var occupied_locations = {}
var enemy_list = {}

var pickup_id_counter = 1
var pickup_max = 500
var pickup_list = {}

func _ready():
	enemy_types = serverdata.enemydata.keys()
	
	var timer = Timer.new()
	timer.wait_time = 3
	timer.autostart = true
	timer.connect("timeout", self, "spawn_enemy")
	self.add_child(timer)
#	spawn_pickup(Vector2(-648, -31), "crate")
	
func spawn_enemy():
	if enemy_list.size() >= enemy_max:
		pass # max enemies already on map
	else:
		randomize()
		var type = enemy_types[randi() % enemy_types.size()]
		var rng_location_index = randi() % open_locations.size()
		var location = enemy_spawn_points[open_locations[rng_location_index]]
#		occupied_locations[enemy_id_counter] = open_locations[rng_location_index]
#		open_locations.remove(rng_location_index)
		var enemy_data = {
			"enemy_type": type, 
			"enemy_location": location, 
			"enemy_max_hp": serverdata.enemydata[type].maxhp, 
			"enemy_hp": serverdata.enemydata[type].maxhp, 
			"enemy_xp_drop": serverdata.enemydata[type].xp_drop, 
			"enemy_credit_drop": serverdata.enemydata[type].credit_drop, 
			"enemy_damage": serverdata.enemydata[type].damage, 
			"enemy_state": "idle", 
			"enemy_dir": 0, 
			"timeout": 1
		}
		enemy_list[enemy_id_counter] = enemy_data
		get_parent().get_node("world_map").spawn_enemy(enemy_id_counter, enemy_data, serverdata.enemydata[type].speed)
		enemy_id_counter += 1
	for enemy in enemy_list.keys(): # respawning enemies
		if enemy_list[enemy]["enemy_state"] == "dead":
			if enemy_list[enemy]["timeout"] == 0:
				print("removed enemy " + str(enemy) + " from list")
				enemy_list.erase(enemy)
			else:
				enemy_list[enemy]["timeout"] -= 1

func npc_hit(enemy_id, damage):
	if enemy_list[enemy_id]["enemy_hp"] <= 0:
		pass
	else:
		enemy_list[enemy_id]["enemy_hp"] -= damage
		if enemy_list[enemy_id]["enemy_hp"] <= 0:
			enemy_list[enemy_id]["enemy_state"] = "dead"
			get_node("/root/server/world_map/enemies/" + str(enemy_id)).queue_free()
#			open_locations.append(occupied_locations[enemy_id])
#			occupied_locations.erase(enemy_id)

#func spawn_pickup(pos, type):
#	if pickup_list.size() >= pickup_max:
#		pass
#	else:
#		pickup_list[pickup_id_counter] = {"pickup_position": pos, "pickup_type": type}
#		pickup_id_counter += 1
