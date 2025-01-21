extends StaticBody2D

const PRE_OIL = preload("res://scenes/oilSpill_large.tscn")

func _ready():
	$area_obastacle.connect("hitted", self, "on_area_hitted")
	$area_obastacle.connect("destroid", self, "on_area_destroid")
	pass
	
func on_area_hitted(damage, health, node):
	pass

func on_area_destroid():
	
	var oil_count = rand_range(3, 8)
	
	for o in range(oil_count):
		var oil = PRE_OIL.instance()
		var angle = randf() * (PI * 2)
		oil.global_position = global_position + Vector2(cos(angle), sin(angle)).normalized() * rand_range(30, 60)
		$'../'.add_child(oil)
	
	$area_obastacle.queue_free()
	$shape.queue_free()
	$anim.play("explode")
	yield($anim, "animation_finished")
	
	queue_free()
