extends Area2D

var rot_vel = PI
var vel = 50
var target

func _ready():
	pass

func _process(delta):
	if target:
		var angle = get_angle_to(target.global_position)
		if abs(angle) > .01:
			rotation += rot_vel * delta * sign(angle)
		translate(Vector2(cos(rotation), sin(rotation)).normalized() * vel * delta)
