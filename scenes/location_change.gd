extends Area2D

@export var target_location: LocationManager.Location
@export var slide_direction: LocationManager.SlideDirection = LocationManager.SlideDirection.NONE


func _on_body_entered(body):
	if body.is_in_group("player"):
		get_node("/root/Main/LocationManager").change(target_location, slide_direction)
