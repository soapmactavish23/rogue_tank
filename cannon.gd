extends Area2D

const PRE_BULLET = preload("res://scenes/turrent_01_bullet.tscn")

func _ready():
	get_parent().connect("player_entered", self, "on_player_entered")

func get_target():
	if $sight.is_colliding():
		return $sight.get_collider()
	return null

func on_player_entered(n):
	if n:
		$shoot_timer.start()
	$sight.enabled = true


func _on_shoot_timer_timeout():
	if $sight.is_colliding():
		shoot()
	else: 
		$smoke.emitting = false

func shoot():
	$smoke.emitting = true
	$cannon_anim.play("shoot")
	$stream_shoot.play()
	var bullet = PRE_BULLET.instance()
	bullet.global_position = global_position
	bullet.dir = Vector2(cos(rotation), sin(rotation))
	bullet.max_dist = get_parent().sensor_radius
	get_parent().get_parent().add_child(bullet)
