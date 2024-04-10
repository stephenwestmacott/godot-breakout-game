extends CharacterBody2D

var SPEED : int = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.DOWN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = move_and_collide(velocity * SPEED * delta)
	if collision:
		var collider = collision.get_collider()
		print(collider.name)
		if collider.name == "Paddle":
			Signals.tri_ball_sig.emit()
			queue_free()
