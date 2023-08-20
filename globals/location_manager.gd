extends Node

enum Location { TOWN, FOREST, DUNGEON }
enum SlideDirection { NONE, LEFT, RIGHT, TOP, BOTTOM }

var current_location_name: String


func _ready():
	var scene = load_location(Location.TOWN, true)
	call_deferred("spawn_player", scene, 0)

	current_location_name = scene.name


func change(location: Location, slide_direction: SlideDirection, player_spawn_index: int):
	var current_name = current_location_name

	call_deferred("exit_current", current_name, slide_direction)

	var scene = load_location(location)
	scene.call_deferred("transition_in", slide_direction)

	call_deferred("spawn_player", scene, player_spawn_index)

	current_location_name = scene.name


func load_location(location: Location, visible: bool = false):
	var location_name = Location.keys()[location].to_lower()
	var scene = load("res://scenes/locations/" + location_name + ".tscn").instantiate()

	scene.visible = visible

	call_deferred("add_child", scene)

	return scene


func exit_current(current_name: String, slide_direction: SlideDirection = SlideDirection.NONE):
	var current = get_node("/root/LocationManager/" + current_name)
	current.call_deferred("transition_out", slide_direction)


func spawn_player(scene: Node, spawn_index: int):
	var spawn_points = get_tree().get_nodes_in_group("player_spawn")

	for spawn_point in spawn_points:
		if scene.is_ancestor_of(spawn_point) and spawn_point.index == spawn_index:
			spawn_point.spawn()
			break
