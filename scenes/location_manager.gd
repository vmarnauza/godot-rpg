class_name LocationManager
extends Node2D

enum Location { TOWN, FOREST, DUNGEON }
enum SlideDirection { NONE, LEFT, RIGHT, TOP, BOTTOM }

var current: Location = Location.TOWN
var previous: Location


func _ready():
	load_location(current)


func change(location: Location, slide_direction: Vector2):
	print("TODO: use slide direction ", slide_direction)
	exit_current()
	load_location(location)
	previous = current
	current = location


func load_location(location: Location):
	var location_name = Location.keys()[location].to_lower()
	print(location_name)
	var scene = load("res://scenes/locations/" + location_name + ".tscn").instantiate()
	call_deferred("add_child", scene)

	return scene


func exit_current():
	var loaded_locations = get_tree().get_nodes_in_group("location")

	for location in loaded_locations:
		location.call_deferred("free")
