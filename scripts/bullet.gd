extends Area2D

var vel = 400
var dir = Vector2(0, -1) setget set_dir

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(dir * vel * delta)


func _on_notifier_screen_exited():
	queue_free()
	pass

func set_dir(val):
	dir = val
	rotation = dir.angle()
	pass