extends Area2D

@export_file("*.tscn") var goto_scene_path
var goto_scene: PackedScene


func _ready():
	goto_scene = load(goto_scene_path)


func _on_body_entered(body):
	if body.is_in_group("player"):
		var current = get_tree().get_nodes_in_group("location")

		for location in current:
			location.call_deferred("free")

		var location = goto_scene.instantiate()

		get_tree().get_root().call_deferred("add_child", location)
