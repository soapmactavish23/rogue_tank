extends StaticBody2D

var bodies = []

func _process(delta):
	print(bodies.size())
	if bodies.size():
		$cannon.look_at(bodies[0].global_position)


func _on_sensor_body_entered(body):
	if(body is KinematicBody2D):
		bodies.append(body)

func _on_sensor_body_exited(body):
	var index = bodies.find(body)
	if index >= 0:
		bodies.remove(index)
