extends Node

var enemydata
var itemdata
var playerdata
var default_data = {
	"credits": 2500,
	"lvl": 1,
	"pos": {
		"x": -40,
		"y": -180
	},
	"spawn": {
		"x": -40,
		"y": -180
	},
	"stats": {
		"xp": 0,
		"sp": 0,
		"maxhp": 100,
		"hp": 100,
		"maxenergy": 100,
		"energy": 100,
		"def": 1,
		"atk": 1,
		"agi": 1
	},
	"inv": {
		0: ["life_berry", 25],
		1: ["medkit", 3]
	}
}

func _ready():
	var playerdata_file = File.new()
	playerdata_file.open("res://data/playergamedata.json", File.READ)
	var playerdata_json = JSON.parse(playerdata_file.get_as_text())
	playerdata_file.close()
	playerdata = playerdata_json.result
	print("initialised player data")
	
	var enemydata_file = File.new()
	enemydata_file.open("res://data/enemydata.json", File.READ)
	var enemydata_json = JSON.parse(enemydata_file.get_as_text())
	enemydata_file.close()
	enemydata = enemydata_json.result
	print("initialised enemy data")
	
	var itemdata_file = File.new()
	itemdata_file.open("res://data/itemdata.json", File.READ)
	var itemdata_json = JSON.parse(itemdata_file.get_as_text())
	itemdata_file.close()
	itemdata = itemdata_json.result
	print("initialised item data")
	
func write_playerdata(playeruser, player_id):
	playerdata[playeruser] = get_parent().get_node("server/" + str(player_id)).playerdata
	var file = File.new()
	file.open("res://data/playergamedata.json", File.WRITE)
	file.store_line(to_json(playerdata))
	file.close()

func write_playerdata_update(playeruser, player_id, newdata):
	playerdata[playeruser] = newdata
	var file = File.new()
	file.open("res://data/playergamedata.json", File.WRITE)
	file.store_line(to_json(playerdata))
	file.close()
#	var player_pos = Vector2(newdata.pos.x, newdata.pos.y)
#	get_parent().get_node("server/world_map/players/" + str(player_id)).set_position(player_pos)
