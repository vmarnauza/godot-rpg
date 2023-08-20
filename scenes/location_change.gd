extends Area2D

@export var target_location: LocationManager.Location
@export var slide_direction: LocationManager.SlideDirection = LocationManager.SlideDirection.NONE
@export var spawn_index: int = 0


func _on_body_entered(body):
	if body.is_in_group("player"):
		LocationManager.change(target_location, slide_direction, spawn_index)
