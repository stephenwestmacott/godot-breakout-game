extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
var width : int

const SPEED = 1000

func _ready():
	anim.play("idle")
	width = $CollisionShape2D.shape.get_height()

func _physics_process(delta):
	position.x = get_global_mouse_position().x
	position.x = clamp(position.x, width/2, get_viewport_rect().size.x - (width/2))
	move_and_collide(velocity * SPEED * delta)


