extends CharacterBody2D

const speed = 650
const MAX_X_VECTOR : float = 0.8
var rand_int : int
var width : int
var tri_ball_pwr = preload("res://Scenes/tri_ball_pwr.tscn")

func _ready():
	velocity = Vector2.ZERO
	width = $CollisionShape2D.shape.get_radius()

func _physics_process(delta):
	position.x = clamp(position.x, width/2, get_viewport_rect().size.x - (width/2))
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.name == "Paddle" :
			$PaddleSFX.play()
			velocity = paddle_bounce(collider)
		elif collider.name == "Walls":
			$WallSFX.play()
			velocity = velocity.bounce(collision.get_normal())
		elif collider.get_parent().name == "Bricks":
			rand_int = randi_range(0,1)
			if rand_int == 0:
				$BrickSFX1.play()
			else :
				$BrickSFX2.play()
			velocity = velocity.bounce(collision.get_normal())
			Signals.brick_killed.emit(collider.position)
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
