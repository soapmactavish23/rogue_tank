extends StaticBody2D

var bodies = []
var rot_vel = PI * .2

const PRE_BULLET = preload("res://scenes/turrent_01_bullet.tscn")

func _process(delta):
	if bodies.size():
		var angle = $cannon.get_angle_to(bodies[0].global_position)
		if abs(angle) > .1:
			$cannon.rotation += rot_vel * delta * sign(angle)
	if $cannon/sight.is_colliding():
		if $cannon.get_collider() != bodies[0]:
			var oldBody = bodies[0]
			var newBodyIndex = bodies.find($cannon/sight.get_collider())
			bodies[0] = $cannon/sight.get_collider()
			bodies[newBodyIndex] = oldBody
	
func _on_sensor_body_entered(body):
	if(body is KinematicBody2D):
		if !bodies.size():
			$shoot_timer.start()
		bodies.append(body)
		$cannon/sight.enabled = true
		

func _on_sensor_body_exited(body):
	var index = bodies.find(body)
	if index >= 0:
		bodies.remove(index)
	if !bodies.size():
		$cannon/sight.enabled = false
		$shoot_timer.stop()


func _on_shoot_timer_timeout():
	if $cannon/sight.is_colliding():
		var bullet = PRE_BULLET.instance()
		bullet.global_position = global_position
		bullet.dir = Vector2(cos($cannon.rotation), sin($cannon.rotation))
		get_parent().add_child(bullet)
