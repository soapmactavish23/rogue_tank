tool
extends StaticBody2D

var bodies = []
var rot_vel = PI * .2

export(float, 0, 360) var start_rot = 0.0 setget set_start_rot
export(float, 100, 1000) var sensor_radius = 0.0 setget set_sensor_radius

const PRE_BULLET = preload("res://scenes/turrent_01_bullet.tscn")

var first_draw = false
export var life = 100

onready var init_life = life
onready var game = get_node('/root/GAME')

signal player_entered(n)
signal player_exited(n)

var dead = false

onready var cannon = $cannon

func _process(delta):
	if Engine.editor_hint:
		return
	
	if bodies.size():
		var angle = cannon.get_angle_to(bodies[0].global_position)
		if abs(angle) > .01:
			cannon.rotation += rot_vel * delta * sign(angle)
			
		if cannon.get_target() != bodies[0]:
			var oldBody = bodies[0]
			var newBodyIndex = bodies.find(cannon.get_target())
			bodies[0] = cannon.get_target()
			bodies[newBodyIndex] = oldBody
	
func _on_sensor_body_entered(body):
	if(body is KinematicBody2D):
		if !bodies.size():
			bodies.append(body)
			emit_signal("player_entered", bodies.size())
			update()
		

func _on_sensor_body_exited(body):
	var index = bodies.find(body)
	if index >= 0:
		bodies.remove(index)
	emit_signal("player_exited", bodies.size())
	update()

func _draw():
	if dead:
		return
	if !first_draw:
		cannon.rotation = deg2rad(start_rot)
		
		var new_shape = CircleShape2D.new()
		new_shape.radius = sensor_radius
		$sensor/shape.shape = new_shape
		
		if !Engine.editor_hint:
			first_draw = false
	if bodies.size():
		draw_circle(Vector2(), $sensor/shape.shape.radius, Color(1, 0, 0, .1))
	draw_circle_arc(Vector2(), $sensor/shape.shape.radius, 0, 360, Color(1, 0, 0, .5))
	
func set_start_rot(val):
	start_rot = val
	if Engine.editor_hint:
		update()

func set_sensor_radius(val):
	sensor_radius = val
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


func _on_wake_spot_damage(damage, node):
	life -= damage
	$stream/stream_hit.play()
	$hp_bar.scale = float(life) / float(init_life)
	if life <= 0:
		set_process(false)
		cannon.queue_free()
		$sensor.disconnect("body_exited", self, "_on_sensor_body_exited")
		$sensor.queue_free()
		$wake_spot.queue_free()
		$hp_bar.queue_free()
		dead = true
		update()
		$explosion/anim.play("explode")
		$stream/stream_explosion.play()
		get_tree().call_group("camera", "shake", 5, 1)
		remove_from_group("radar_entity")
		GAME.add_score(250)
