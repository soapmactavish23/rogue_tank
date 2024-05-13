extends StaticBody2D

var pre_bullet = preload("res://scenes/bullet.tscn")
var BULLET_TANK_GROUP = "bullet-" + str(self)

var entred = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if entred:
		var position_player = get_tree().get_nodes_in_group("player")[0]
		look_at(position_player.global_position)
		
		if get_tree().get_nodes_in_group(BULLET_TANK_GROUP).size() < 1:
			var bullet = pre_bullet.instance()
			bullet.global_position = $barrel/muzzle.global_position
			
			bullet.dir = Vector2(cos(rotation), sin(rotation)).normalized()
			bullet.add_to_group(BULLET_TANK_GROUP)
			$barrel/anim.play("fire")
			get_parent().add_child(bullet)


func _on_area_body_entered( body ):
	if body.is_in_group("player"):
		entred = true


func _on_area_body_exited( body ):
	if body.is_in_group("player"):
		entred = false
