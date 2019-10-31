extends KinematicBody2D

const TYPE = "PLAYER"
const FLOOR = Vector2(0, -1)
const projectile_scene = preload("Projectile.tscn")

export var GRAVITY = 1600
var move_speed = 400
var jump_velocity = -600
var velocity = Vector2()
var is_grounded = false
var knockdir = Vector2()
var hitstun = 0
var health = 1

onready var rayCasts = get_node("RayCasts")
onready var timer = get_node("HandgunTimer")
onready var position2D = get_node("facingPosition")

func _ready():
	timer.set_active(false)
	set_physics_process(true)

func _physics_process(delta):
	if hitstun == 0:
		get_input_axis()
		velocity.y += GRAVITY * delta
	else:
		velocity = knockdir * move_speed * 1.5
	velocity = move_and_slide(velocity, FLOOR)
	damage_loop()
	if is_on_floor():
		is_grounded = true
	else:
		is_grounded = false
	
	if Input.is_action_pressed("fire_handgun"):
		if not timer.is_active():
			fire_projectile()
			restart_timer()
		
	


func get_input_axis():
	var move_direction = 0
	if Input.is_action_pressed("move_right"):
		move_direction = 1
		if sign(position2D.get_position().x) == -1:
			position2D.set_position(Vector2(position2D.get_position().x * -1, 0))
	if Input.is_action_pressed("move_left"):
		move_direction = -1
		if sign(position2D.get_position().x) == 1:
			position2D.set_position(Vector2(position2D.get_position().x * -1, 0))
	if Input.is_action_pressed("move_down"):
		if sign(position2D.get_position().y) == -1:
			position2D.set_position(Vector2(0, position2D.get_position().y * -1))
	if Input.is_action_pressed("move_up"):
		if sign(position2D.get_position().y) == 1:
			position2D.set_position(Vector2(0, position2D.get_position().y * -1))
	velocity.x = lerp(velocity.x, move_speed * move_direction, _get_h_weight())
	if Input.is_action_pressed("jump") && is_grounded == true:
		velocity.y = jump_velocity
		is_grounded = false

func _get_h_weight():
	return 0.2 if is_grounded else 0.1

func check_is_grounded():
	for raycast in rayCasts.get_children():
		if raycast.is_colliding():
			return true
		else:
			return false

func fire_projectile():
		var projectile = projectile_scene.instance()
		get_parent().add_child(projectile)
		projectile.set_position(position2D.get_global_position())
		if sign(position2D.get_position().x) == 1:
			projectile.set_projectile_direction_x(1)
		else:
			projectile.set_projectile_direction_x(-1)
		if Input.is_action_pressed("move_up"):
			projectile.set_projectile_direction_y(-1)
		elif Input.is_action_pressed("move_down"):
			projectile.set_projectile_direction_y(1)
		else:
			projectile.set_projectile_direction_y(0)

func restart_timer():
	timer.set_wait_time(.15)
	timer.set_active(true)
	timer.start()

func _on_HandgunTimer_timeout():
	timer.set_active(false)

func damage_loop():
	if hitstun > 0:
		hitstun -= 1
	for body in get_node("hitbox").get_overlapping_bodies():
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = self.transform.origin - body.transform.origin
