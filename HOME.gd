extends Area2D

const PRE_MISSEL = preload("res://scenes/home_missel.tscn")
var rot_vel = PI * .1

func _ready():
	pass

func get_target():
	var tank = get_parent().bodies[0]
	var ht = (tank.global_position - global_position).normalized()
	var facing = Vector2(cos(rotation), sin(rotation))
	
	if ht.dot(facing) > 0:
		if $fire_timer.is_stopped():
			fire()
			$fire_timer.start()
	else:
		$fire_timer.stop()
		
	return null

func fire():
	if get_parent().bodies.size():
		$anim.play("fire")
		$fire.play()
		$smoke.emitting = true
		var missel = PRE_MISSEL.instance()
		get_parent().add_child(missel)
		missel.rotation = rotation
		missel.target = get_parent().bodies[0]
		missel.global_position = $barrel.global_position
	else:
		$fire_timer.stop()

func _on_firetimer_timeout():
	fire()
