tool
extends KinematicBody2D

# PI = 180 graus
const ROT_VEL = PI / 2
const MAX_SPEED = 150

var acell = 0
var travel = 0
var loaded = true
var BULLET_TANK_GROUP = "bullet-" + str(self)

var pre_bullet = preload("res://scenes/bullet.tscn")
var pre_track = preload("res://scenes/track.tscn")

export(int, "green", "bigRed", "blue", "dark", "darkLarge", "huge", "sand") var body = 0 setget set_body
export(int, "green", "bigRed", "blue", "dark", "darkLarge", "huge", "sand") var barrel = 0 setget set_barrel

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
	pass

func _draw():
	$sprite.texture = load(bodies[body])
	$barrel/sprite.texture = load(barrels[barrel])
	
func _physics_process(delta):
	
	if Engine.editor_hint:
		return
		
	var vel_mod = 1
	
	if get_tree().get_nodes_in_group(str(self) + "-oil").size() > 0:
		vel_mod = .3
	
		
	if Input.is_action_just_pressed(("ui_shoot")) and loaded:
		var bullet = pre_bullet.instance()
		bullet.global_position = $barrel/muzzle.global_position
		$barrel/fx.play()

		bullet.dir = Vector2(cos($barrel.global_rotation), sin($barrel.global_rotation)).normalized()
		bullet.add_to_group(BULLET_TANK_GROUP)
		bullet.max_dist = $barrel/sight.position.x - $barrel/muzzle.position.x
		get_parent().add_child(bullet)
		$barrel/anim.play("fire")
		loaded = false
		$barrel/sight.update()
		$timer_reload.start()
		$barrel/barrel_anim.play("shoot")

	var rot = 0
	var dir = 0

	if Input.is_action_pressed("ui_right"):
		rot += 1
		pass
		
	if Input.is_action_pressed("ui_left"):
		rot -= 1
		pass
	
	if Input.is_action_pressed("ui_up"):
		dir += 1
	
	if Input.is_action_pressed("ui_down"):
		dir -= 1
		
	rotate(ROT_VEL * rot * delta)
	
	
	if dir != 0:
		acell = lerp(acell, MAX_SPEED, .01)
	else:
		acell = lerp(acell, 0, .05)
	
	var move = move_and_slide(Vector2(cos(rotation), sin(rotation)) * dir * acell * vel_mod)
	
	travel += move.length() * delta
	
	if travel > $sprite.texture.get_size().y:
		travel = 0
		var track = pre_track.instance()
		track.global_position = global_position - Vector2(cos(rotation), sin(rotation)).normalized() * 5
		track.rotation = rotation
		track.z_index = z_index - 1
		$"../".add_child(track)
	
	$barrel.look_at(get_global_mouse_position())

func set_body(val):
	body = val
	if Engine.editor_hint:
		update()

func set_barrel(val):
	barrel = val
	if Engine.editor_hint:
		update()

func _on_timer_reload_timeout():
	loaded = true
	$barrel/sight.update()
