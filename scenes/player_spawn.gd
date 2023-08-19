extends Area2D

@export var player_scene: PackedScene


func _ready():
	var player = player_scene.instantiate()

	player.position = Vector2(0, 0)

	call_deferred("add_child", player)
