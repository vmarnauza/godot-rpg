extends Node

enum Location { TOWN, FOREST, DUNGEON }
enum SlideDirection { NONE, LEFT, RIGHT, TOP, BOTTOM }


func _ready():
	call_deferred("spawn_player", 0)


func change(location: Location, slide_direction: SlideDirection, player_spawn_index: int):
	print("TODO: use slide direction ", slide_direction)
	exit_current()
	load_location(location)
	call_deferred("spawn_player", player_spawn_index)


func load_location(location: Location):
	var location_name = Location.keys()[location].to_lower()
	var scene = load("res://scenes/locations/" + location_name + ".tscn").instantiate()

	call_deferred("add_child", scene)


func exit_current():
	var loaded_locations = get_tree().get_nodes_in_group("location")

	for location in loaded_locations:
		location.call_deferred("free")


func spawn_player(spawn_index: int):
	var spawn_points = get_tree().get_nodes_in_group("player_spawn")

	for spawn_point in spawn_points:
		if spawn_point.index == spawn_index:
			spawn_point.spawn()
			break
