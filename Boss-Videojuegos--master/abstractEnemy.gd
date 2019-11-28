extends KinematicBody2D

const projectile_scene = preload("Projectile.tscn")
const DAMAGE = 1
const TYPE = "ENEMY"

var SPEED = 0
var GRAVITY = 0
var velocity = Vector2(-1, 0)
var knockdir = Vector2()
var hitstun = 0
var health = 2

func _ready():
	SPEED = 200
	GRAVITY = 800

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
	get_parent().call_deferred("add_child", projectile)
	projectile.set_position(position)
	projectile.set_projectile_direction_x(x)
	projectile.set_projectile_direction_y(y)
		
func die():
	queue_free()