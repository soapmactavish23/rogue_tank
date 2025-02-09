extends Area2D

const rot_vel = PI * .1

func _ready():
	pass

func get_target():
	print(get_parent().bodies[0])
	var tank = get_parent().bodies[0]
	var ht = (tank.global_position - global_position).normalized()
	var facing = Vector2(cos(rotation), sin(rotation))
	
	if ht.dot(facing) > 0:
		print('fire')
	return null
