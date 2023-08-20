extends TileMap

var tween: Tween = null


func transition_in(direction: int):
	disable_colliders()
	tween = create_tween()
	var screen_size = get_viewport_rect().size
	if direction == LocationManager.SlideDirection.NONE:
		modulate.a = 0
		visible = true

		tween.tween_property(self, "modulate:a", 1, 0.2).set_ease(Tween.EASE_OUT).set_trans(
			Tween.TRANS_SINE
		)

	else:
		var finish_pos = Vector2.ZERO
		var start_pos = Vector2.ZERO

		match direction:
			LocationManager.SlideDirection.RIGHT:
				start_pos = Vector2(screen_size.x, 0)
			LocationManager.SlideDirection.BOTTOM:
				start_pos = Vector2(0, screen_size.y)
			LocationManager.SlideDirection.LEFT:
				start_pos = Vector2(-screen_size.x, 0)
			LocationManager.SlideDirection.TOP:
				start_pos = Vector2(0, -screen_size.y)

		position = start_pos
		visible = true

		tween.tween_property(self, "position", finish_pos, 0.3).set_ease(Tween.EASE_OUT).set_trans(
			Tween.TRANS_SINE
		)

	tween.tween_callback(self.enable_colliders)


func transition_out(direction: int):
	disable_colliders()

	tween = create_tween()
	var screen_size = get_viewport_rect().size
	if direction == LocationManager.SlideDirection.NONE:
		visible = true

		tween.tween_property(self, "modulate:a", 0, 0.1).set_ease(Tween.EASE_OUT).set_trans(
			Tween.TRANS_SINE
		)

	else:
		var finish_pos = Vector2.ZERO

		match direction:
			LocationManager.SlideDirection.RIGHT:
				finish_pos = Vector2(-screen_size.x, 0)
			LocationManager.SlideDirection.BOTTOM:
				finish_pos = Vector2(0, -screen_size.y)
			LocationManager.SlideDirection.LEFT:
				finish_pos = Vector2(screen_size.x, 0)
			LocationManager.SlideDirection.TOP:
				finish_pos = Vector2(0, screen_size.y)

		visible = true

		tween.tween_property(self, "position", finish_pos, 0.3).set_ease(Tween.EASE_OUT).set_trans(
			Tween.TRANS_SINE
		)

	tween.tween_callback(self.queue_free)


func disable_colliders():
	toggle_colliders(false)


func enable_colliders():
	toggle_colliders(true)


func toggle_colliders(enabled: bool):
	for child in get_children():
		if child is Area2D:
			for grandchild in child.get_children():
				if grandchild is CollisionShape2D:
					grandchild.disabled = !enabled
