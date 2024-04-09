extends CharacterBody2D

const SPEED = 650
const MAX_X_VECTOR : float = 0.8

func _ready():
	velocity = Vector2.ZERO

func _physics_process(delta):
	var collision = move_and_collide(velocity * SPEED * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.name == "Paddle" :
			velocity = paddle_bounce(collider)
		elif collider.name == "Walls":
			print(collider.name)
			velocity = velocity.bounce(collision.get_normal())
		else:
			velocity = velocity.bounce(collision.get_normal())
			collider.free()

func paddle_bounce(collider):
	var ball_x = position.x
	var pad_x = collider.position.x
	var dist = ball_x - pad_x
	var new_velocity := Vector2()
	
	new_velocity.y = -1
	new_velocity.x = (dist/((collider.width)/2)) * MAX_X_VECTOR
	
	return new_velocity.normalized()

func launch_ball():
	velocity = Vector2(randf_range(-0.1, 0.1), randf_range(-1, -0.8)).normalized()
	
