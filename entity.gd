extends KinematicBody2D

const TYPE = ""
const FLOOR = Vector2(0, -1)
const projectile_scene = preload("Projectile.tscn")


export var GRAVITY = 1600
var move_speed = 400
var jump_velocity = -600
var velocity = Vector2()
var is_grounded = false
var knockdir = Vector2()
var hitstun = 0
var health = 3
var timerWait = 0.5

onready var timer = get_node("HandgunTimer")
onready var position2D = get_node("facingPosition")

func movement_loop(delta):
	if hitstun == 0:
		get_input_axis()
		velocity.y += GRAVITY * delta
		velocity = velocity * move_speed
	else:
		velocity = knockdir * move_speed * 1.5
	move_and_slide(velocity, Vector2(0, -1))

func damage_loop():
	if hitstun > 0:
		hitstun -= 1
	for body in get_node("hitbox").get_overlapping_bodies():
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = self.transform.origin - body.transform.origin

func get_input_axis():
	pass
