extends RigidBody2D

export var boncing = 0.3

func _ready():
	bounce = boncing
	gravity_scale = 0
	linear_damp = 1
	angular_velocity = randf() * 1
	var dir = randf() * (PI * 2)
	apply_impulse(Vector2(), Vector2(cos(dir), sin(dir)) * 200)
	$poly.scale = get_parent().scale
	$poly2.scale = get_parent().scale
	$poly.rotation = get_parent().rotation
	$poly2.rotation = get_parent().rotation