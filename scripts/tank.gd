extends KinematicBody2D


func _ready():
	pass
	
func _process(delta):
	
	translate(Vector2(10, 0) * delta)
	
