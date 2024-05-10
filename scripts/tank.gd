extends KinematicBody2D

var speed = 150
var pre_bullet = preload("res://scenes/bullet.tscn")

export(int, "green", "bigRed") var body = 0
export var barrel = 0

var bodies = [
	"res://sprites/tankBody_green.png",
	"res://sprites/tankBody_bigRed.png",
	"res://sprites/tankBody_blue.png",
	"res://sprites/tankBody_dark.png",
	"res://sprites/tankBody_darkLarge.png",
	"res://sprites/tankBody_huge.png",
	"res://sprites/tankBody_sand.png"
]

var barrels = [
	"res://sprites/tankDark_barrel1_outline.png",
	"res://sprites/tankDark_barrel1.png",
	"res://sprites/tankBlue_barrel1.png",
	"res://sprites/tankGreen_barrel1.png",
	"res://sprites/tankSand_barrel1.png",
	"res://sprites/tankRed_barrel1.png"
]

func _ready():
	$sprite.texture = load(bodies[body])
	$barrel/sprite.texture = load(barrels[barrel])
	pass
	
func _process(delta):
	
	var dir_x = 0
	var dir_y = 0
	
	if Input.is_action_pressed("ui_right"):
		dir_x += 1
	if Input.is_action_pressed("ui_left"):
		dir_x -= 1
	if Input.is_action_pressed("ui_up"):
		dir_y -= 1
	if Input.is_action_pressed("ui_down"):
		dir_y += 1
	
	if Input.is_action_just_pressed(("ui_shoot")):
		if get_tree().get_nodes_in_group("cannon_bullets").size() < 6:
			var bullet = pre_bullet.instance()
			bullet.global_position = $barrel/muzzle.global_position
			
			bullet.dir = Vector2(cos(rotation), sin(rotation)).normalized()
			$barrel/anim.play("fire")
			get_parent().add_child(bullet)
		
	look_at(get_global_mouse_position())
		
	
	
	translate(Vector2(dir_x, dir_y) * delta * speed)
	
	pass
