extends KinematicBody2D

const TYPE = "PLAYER"
const FLOOR = Vector2(0, -1)
const projectile_scene = preload("Projectile.tscn")


export var GRAVITY = 1600
var max_health = 5
var move_speed = 400
var jump_velocity = -600
var velocity = Vector2()
var is_grounded = false
var knockdir = Vector2()
var hitstun = 0
var health = 3
var timerWait = 0.5
var weight = 6

onready var timer = get_node("HandgunTimer")
onready var position2D = get_node("facingPosition")

func _ready():
	timer.stop()
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
		if timer.is_stopped():
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
	velocity.x = lerp(velocity.x, (move_speed * boost()) * move_direction, _get_h_weight())
	if Input.is_action_pressed("jump") && is_grounded == true:
		velocity.y = jump_velocity * boost()
		is_grounded = false

func _get_h_weight():
	return 0.2 if is_grounded else 0.1

func fire_projectile():
		var projectile = projectile_scene.instance()
		projectile.set_type(TYPE)
		get_parent().add_child(projectile)
		projectile.set_position(position2D.get_global_position())
		if sign(position2D.get_position().x) == 1:
			projectile.set_projectile_direction_x(1)
		else:
			projectile.set_projectile_direction_x(-1)
		if Input.is_action_pressed("move_up") && Input.is_action_pressed("move_right"):
			projectile.set_projectile_direction_y(-1)
			projectile.set_projectile_direction_x(1)
		elif Input.is_action_pressed("move_down") && Input.is_action_pressed("move_right"):
			projectile.set_projectile_direction_y(1)
			projectile.set_projectile_direction_x(1)
		elif Input.is_action_pressed("move_up") && Input.is_action_pressed("move_left"):
			projectile.set_projectile_direction_y(-1)
			projectile.set_projectile_direction_x(-1)
		elif Input.is_action_pressed("move_down") && Input.is_action_pressed("move_left"):
			projectile.set_projectile_direction_y(1)
			projectile.set_projectile_direction_x(-1)
		elif Input.is_action_pressed("move_up"):
			projectile.set_projectile_direction_y(-1)
			projectile.set_projectile_direction_x(0)
		elif Input.is_action_pressed("move_down"):
			projectile.set_projectile_direction_y(1)
			projectile.set_projectile_direction_x(0)
		
		
		else:
			projectile.set_projectile_direction_y(0)

func restart_timer():
	timer.set_wait_time(2 - boost())
	timer.start()

func _on_HandgunTimer_timeout():
	timer.stop()

func damage_loop():
	if hitstun > 0:
		hitstun -= 1
	for body in get_node("hitbox").get_overlapping_bodies():
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			hitstun = 10
			if sign(position2D.get_position().x) == 1:
				knockdir = move_and_slide(Vector2(-0.5, -0.5))
			elif sign(position2D.get_position().x) == -1:
				knockdir = move_and_slide(Vector2(0.5, -0.5))
		elif health == 0:
			queue_free()
			#get_tree().change_scene("lost")

func boost():
	var boost
	match health 
		1:
			boost = 1.75
		2:
			boost = 1.5
		3:
			boost =  1
		4:
			boost =  0.5
		5:
			boost =  0.25
	return boost

func on_projectile_hit(damage):
	health -= damage
	update_weight()

func update_weight():
	match health 
		1:
			weight = 2
		2:
			weight = 4
		3:
			weight = 6
		4:
			weight = 8
		5:
			weight = 10
