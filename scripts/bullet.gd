extends Area2D

const MAX_DIST = 100

var vel = 400
var dir = Vector2(0, -1) setget set_dir
onready var init_pos = global_position

var live = true

func _ready():
	pass

func _process(delta):
	
	if live:
		if global_position.distance_to(init_pos) >= MAX_DIST:
			$smoke.emitting = false
			live = false
			$sprite.visible = false
			$anim_self_destruction.play("explode")
			monitoring = false
			monitorable = false
			yield($anim_self_destruction, "animation_finished")
			queue_free()
	
		translate(dir * vel * delta)

func _on_notifier_screen_exited():
	queue_free()
	pass

func set_dir(val):
	dir = val
	rotation = dir.angle()
	pass