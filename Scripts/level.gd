extends Node2D

var new_ball : bool
var lives : int
var ball = preload("res://Scenes/ball.tscn")
var tri_ball_pwr = preload("res://Scenes/tri_ball_pwr.tscn")
var ball_path : String 
var ball_count : int
var brick_count : int
var pwr_spawn_position : int
var ball_that_killed_brick : Object

# Called when the node enters the scene tree for the first time.
func _ready():
	new_ball = true
	lives = 3
	ball_path = $Balls/Ball.get_path()
	ball_count = 1
	brick_count = $Bricks.get_child_count()
	Signals.brick_killed.connect(_spawn_tri_ball_pwr)
	Signals.brick_killed.connect(_dec_brick_count)
	Signals.tri_ball_sig.connect(_tri_ball)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	# new ball follow paddle, and launch on input
	if new_ball == true:
		get_node(ball_path).position.x = $Paddle.position.x
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and new_ball == true:
		get_node(ball_path).launch_ball()
		new_ball = false

func _on_ball_killer_body_entered(body):
	if body.get_parent() == $Balls:
		body.queue_free()
		ball_count -= 1
		if ball_count == 0:
			_remove_life()
			if lives >= 1:
				_spawn_ball()
	body.queue_free()

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
	var instance = ball.instantiate()
	instance.position.y = 1231
	$Balls.add_child(instance)
	ball_path = instance.get_path()
	new_ball = true
	ball_count += 1

func _spawn_tri_ball_pwr(brick_position):
	var spawn_odds = randi_range(0,4)
	print(spawn_odds)
	if spawn_odds == 3:
		var instance = tri_ball_pwr.instantiate()
		instance.position = brick_position
		$PowerUps/TriBall.add_child(instance)

func _tri_ball():
	var instance
	for i in 3:
		instance = ball.instantiate()
		instance.position.y = 1230
		instance.position.x = $Paddle.position.x
		$Balls.add_child(instance)
		ball_count += 1
		instance.launch_ball()

func _dec_brick_count(brick_position):
	brick_count -= 1
