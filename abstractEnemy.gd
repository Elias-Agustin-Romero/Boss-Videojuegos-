extends KinematicBody2D

onready var left  = $RayCastLeft
onready var right = $RayCastRight

const projectile_scene = preload("Projectile.tscn")
const DAMAGE = 1

var TYPE = "ENEMY"
var SPEED = 0
var GRAVITY = 0
var velocity = Vector2(-1, 0)
var knockdir = Vector2()
var hitstun = 0
var health = 2


func _ready():
	SPEED = 150
	GRAVITY = 200
	set_physics_process(false)

func get_input_axis():
	velocity.x = -1

func movement_loop(delta):
	pass

func damage_loop():
	if hitstun > 0:
		hitstun -= 1
	for body in get_node("hitbox").get_overlapping_bodies():
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = transform.origin - body.transform.origin

func on_projectile_hit(damage):
	health = health - damage
	if (health<=0):
		self.die()

func shoot(x, y):
	var projectile = projectile_scene.instance()
	projectile.set_type(TYPE)
	projectile.set_collision_layer_bit(10,true)
	projectile.set_collision_mask_bit(10,true)
	projectile.set_position(position)
	projectile.set_projectile_direction_x(x)
	projectile.set_projectile_direction_y(y)
	get_parent().call_deferred("add_child", projectile)
		


func die():
	queue_free()

func _on_VisibilityNotifier2D_screen_entered():
	set_physics_process(true)


func _on_VisibilityNotifier2D_screen_exited():
	die()
