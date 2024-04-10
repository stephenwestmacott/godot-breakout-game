extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var ran = randi_range(0, 7)
	if ran == 0:
		$Sprite2D.texture = load("res://Assets/Bricks/01-Breakout-Tiles.png")
	elif ran == 1:
		$Sprite2D.texture = load("res://Assets/Bricks/03-Breakout-Tiles.png")
	elif ran == 2:
		$Sprite2D.texture = load("res://Assets/Bricks/05-Breakout-Tiles.png")
	elif ran == 3:
		$Sprite2D.texture = load("res://Assets/Bricks/07-Breakout-Tiles.png")
	elif ran == 4:
		$Sprite2D.texture = load("res://Assets/Bricks/09-Breakout-Tiles.png")
	elif ran == 5:
		$Sprite2D.texture = load("res://Assets/Bricks/11-Breakout-Tiles.png")
	elif ran == 6:
		$Sprite2D.texture = load("res://Assets/Bricks/13-Breakout-Tiles.png")
	elif ran == 7:
		$Sprite2D.texture = load("res://Assets/Bricks/15-Breakout-Tiles.png")

