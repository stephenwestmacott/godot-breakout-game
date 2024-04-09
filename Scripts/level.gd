extends Node2D

var new_ball : bool
var lives : int
var ball = preload("res://Scenes/ball.tscn")
var ball_path : String 

# Called when the node enters the scene tree for the first time.
func _ready():
	new_ball = true
	lives = 3
	ball_path = $Ball.get_path()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if new_ball == true:
		get_node(ball_path).position.x = $Paddle.position.x
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and new_ball == true:
		get_node(ball_path).launch_ball()
		new_ball = false

func _on_ball_killer_body_entered(body):
	body.queue_free()
	_remove_life()
	if lives >= 1:
		_spawn_ball()

func _remove_life():
	lives -= 1
	if lives == 2:
		$HBoxContainer/Life1.visible = true
		$HBoxContainer/Life2.visible = true
		$HBoxContainer/Life3.visible = false
	if lives == 1:
		$HBoxContainer/Life1.visible = true
		$HBoxContainer/Life2.visible = false
		$HBoxContainer/Life3.visible = false
	if lives == 0:
		$HBoxContainer/Life1.visible = false
		$HBoxContainer/Life2.visible = false
		$HBoxContainer/Life3.visible = false

func _spawn_ball():
	new_ball = true
	var instance = ball.instantiate()
	instance.position.y = 671
	add_child(instance)
	ball_path = instance.get_path()
	
