tool
extends StaticBody2D

var bodies = []
var rot_vel = PI * .2

export(float, 0, 360) var start_rot = 0.0 setget set_start_rot

const PRE_BULLET = preload("res://scenes/turrent_01_bullet.tscn")

var first_draw = false

func _process(delta):
	if bodies.size():
		var angle = $cannon.get_angle_to(bodies[0].global_position)
		if abs(angle) > .1:
			$cannon.rotation += rot_vel * delta * sign(angle)
	if $cannon/sight.is_colliding() && bodies.size() > 0:
		if $cannon/sight.get_collider() != bodies[0]:
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
		update()
		

func _on_sensor_body_exited(body):
	var index = bodies.find(body)
	if index >= 0:
		bodies.remove(index)
	if !bodies.size():
		$cannon/sight.enabled = false
		$shoot_timer.stop()
		$cannon/smoke.emitting = false
	update()

func _draw():
	if !first_draw:
		$cannon.rotation = deg2rad(start_rot)
		first_draw = false
	if bodies.size():
		draw_circle(Vector2(), $sensor/shape.shape.radius, Color(1, 0, 0, .1))
	draw_circle_arc(Vector2(), $sensor/shape.shape.radius, 0, 360, Color(1, 0, 0, .5))

func _on_shoot_timer_timeout():
	if $cannon/sight.is_colliding():
		shoot()
	else: 
		$cannon/smoke.emitting = false
		
func shoot():
	$cannon/smoke.emitting = true
	$cannon_anim.play("shoot")
	$stream_shoot.play()
	var bullet = PRE_BULLET.instance()
	bullet.global_position = global_position
	bullet.dir = Vector2(cos($cannon.rotation), sin($cannon.rotation))
	get_parent().add_child(bullet)
	
func set_start_rot(val):
	start_rot = val
	if Engine.editor_hint:
		update()

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points * 90)
		points_arc.push_back(center * Vector2(cos(angle_point), sin(angle_point)) * radius)
		
	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)
		
		
