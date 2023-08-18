extends Area2D

const SPEED = 50.0

@onready var sprite = $AnimatedSprite2D


func _physics_process(delta):
	var direction = Vector2.ZERO

	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")

	move(direction, delta)
	set_animation(direction)


func move(direction: Vector2, delta: float):
	var velocity = Vector2.ZERO

	if direction.x:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction.y:
		velocity.y = direction.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	position += velocity * delta


func set_animation(direction: Vector2):
	if direction.x != 0:
		sprite.play("walk_right")
		sprite.flip_h = direction.x < 0
	elif direction.y < 0:
		sprite.play("walk_up")
	elif direction.y > 0:
		sprite.play("walk_down")
	elif (
		(Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"))
		and direction.y == 0
	):
		sprite.play("idle_right")
	elif Input.is_action_just_released("move_up") and direction.x == 0:
		sprite.play("idle_up")
	elif Input.is_action_just_released("move_down") and direction.x == 0:
		sprite.play("idle_down")
