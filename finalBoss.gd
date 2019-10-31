extends KinematicBody2D

const DAMAGE = 1
const TYPE = "ENEMY"
onready var player = get_parent().get_node("player")
onready var timer = get_node("Timer")
const projectile_scene = preload("Projectile.tscn")

var SPEED = 0
var GRAVITY = 0
var velocity = Vector2(-1, 0)
var knockdir = Vector2()
var hitstun = 0
var health = 10

func _ready():
	SPEED = 200
	GRAVITY = 800
	timer.stop()

func _physics_process(delta):
	if get_parent().get_children().has(player):
		look_at(player.position)
		if timer.is_stopped():
			fire_projectile()
			restart_timer()

func get_input_axis():
	velocity.x = -1

func movement_loop(delta):
#	if hitstun == 0:
	pass
#	else:
#		velocity = knockdir * SPEED * 1.5

func damage_loop():
	if hitstun > 0:
		hitstun -= 1
	for body in get_node("hitbox").get_overlapping_bodies():
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = transform.origin - body.transform.origin


func on_projectile_hit(damage):
	if health > 0:
		health -= damage
	else:
		get_tree().quit()
		queue_free()

func fire_projectile():
		var projectile = projectile_scene.instance()
		projectile.set_type(TYPE)
		get_parent().add_child(projectile)
		projectile.set_position(position)
		projectile.set_projectile_direction_x(randf())
		projectile.set_projectile_direction_y(randf())
		randomize()

func restart_timer():
	timer.set_wait_time(1)
	timer.start()

func _on_Timer_timeout():
		timer.stop()

