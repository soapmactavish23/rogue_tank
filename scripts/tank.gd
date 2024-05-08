extends KinematicBody2D

var speed = 100

func _ready():
	pass
	
func _process(delta):
	
	var dir_x = 0
	
	if Input.is_action_pressed("ui_right"):
		dir_x += 1
	if Input.is_action_pressed("ui_left"):
		dir_x -= 1
	
	
	translate(Vector2(dir_x, 0) * delta * speed)
	
	pass
