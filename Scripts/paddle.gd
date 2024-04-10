extends StaticBody2D

@onready var anim = $AnimatedSprite2D

var width : int
var velocity
const SPEED = 1000

func _ready():
	anim.play("idle")
	width = $CollisionShape2D.shape.get_height()
	velocity = Vector2.ZERO

func _physics_process(delta):
	position.x = get_global_mouse_position().x
	position.x = clamp(position.x, width/2, get_viewport_rect().size.x - (width/2))
	position.y = clamp(position.y, 1259, 1261)
	move_and_collide(velocity * SPEED * delta)
