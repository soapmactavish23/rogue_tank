extends Area2D

var rot_vel = PI
var vel = 150
var target
var homming = false

func _ready():
	yield(get_tree().create_timer(1), "timeout")
	homming = true

func _process(delta):
	if target:
		if homming:
			var angle = get_angle_to(target.global_position)
			if abs(angle) > .01:
				rotation += rot_vel * delta * sign(angle)
		translate(Vector2(cos(rotation), sin(rotation)).normalized() * vel * delta)


func _on_home_missel_body_entered(body):
	if body is KinematicBody2D:
		queue_free()
