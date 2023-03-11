extends Node2D

var sync_clock_counter = 0

var world_state = {}

func _physics_process(delta):
	sync_clock_counter += 1
	if sync_clock_counter == 3:
		sync_clock_counter = 0
		if not get_parent().player_state_collection.empty():
			world_state = get_parent().player_state_collection.duplicate(true)
			for player in world_state.keys():
				world_state[player].erase("t")
			world_state["t"] = OS.get_system_time_msecs()
			world_state["enemies"] = get_node("../map").enemy_list
			#world_state["pickups"] = get_node("../map").pickup_list
			# verifications
			# anti cheat
			# cuts ( chunking / maps )
			# physics checks
			# anything else that must be done
			get_parent().send_world_state(world_state)
