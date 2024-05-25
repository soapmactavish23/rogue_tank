extends StaticBody2D

func _ready():
	$area_obastacle.connect("hitted", self, "on_area_hitted")
	$area_obastacle.connect("destroid", self, "on_area_destroid")
	pass
	
func on_area_hitted(damage, health, node):
	if damage > 5:
		$anim.play("big_hit")
	else:
		$anim.play("small_hit")

func on_area_destroid():
	queue_free()