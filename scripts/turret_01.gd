extends StaticBody2D

var bodies = []
var rot_vel = PI * .2

func _process(delta):
	if bodies.size():
		var angle = $cannon.get_angle_to(bodies[0].global_position)
		if abs(angle) > .1:
			$cannon.rotation += rot_vel * delta * sign(angle)
		#$cannon.look_at(bodies[0].global_position)


func _on_sensor_body_entered(body):
	if(body is KinematicBody2D):
		bodies.append(body)

func _on_sensor_body_exited(body):
	var index = bodies.find(body)
	if index >= 0:
		bodies.remove(index)
