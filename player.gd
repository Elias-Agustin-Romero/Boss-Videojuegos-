extends KinematicBody2D

signal player_died
const TYPE = "PLAYER"
const FLOOR = Vector2(0, -1)
const projectile_scene = preload("Projectile.tscn")
const platformScene = preload("Platform.tscn")


export var GRAVITY = 1600
var velocity = Vector2()
var is_grounded = false
var knockdir = Vector2()
var hitstun = 0
var health = 5

var move_speed
var jump_velocity
var timerWait

onready var timer = get_node("HandgunTimer")
onready var position2D = get_node("facingPosition")
onready var timer2 = get_node("Timer")

func _ready():
	boost()
	timer.stop()
	timer2.stop()
	set_physics_process(true)

func _physics_process(delta):
	if health > 0:
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
	else:
		die()
	


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
	velocity.x = lerp(velocity.x, (move_speed) * move_direction, _get_h_weight())
	if Input.is_action_pressed("jump") && is_grounded == true:
		velocity.y = jump_velocity 
		is_grounded = false

func _get_h_weight():
	return 0.2 if is_grounded else 0.1

func fire_projectile():
		var projectile = projectile_scene.instance()
		projectile.set_type(TYPE)
		get_parent().add_child(projectile)
		projectile.set_collision_layer_bit(5,true)
		projectile.set_collision_mask_bit(5,true)
		projectile.set_position(position2D.get_global_position())
		if sign(position2D.get_position().x) == 1:
			projectile.set_projectile_direction_x(1)
		else:
			projectile.set_projectile_direction_x(-1)
		if Input.is_action_pressed("move_up") && Input.is_action_pressed("move_right"):
			projectile.set_proyectile_direction(1,-1)
		elif Input.is_action_pressed("move_down") && Input.is_action_pressed("move_right"):
			projectile.set_proyectile_direction(1,1)
		elif Input.is_action_pressed("move_up") && Input.is_action_pressed("move_left"):
			projectile.set_proyectile_direction(-1,-1)
		elif Input.is_action_pressed("move_down") && Input.is_action_pressed("move_left"):
			projectile.set_proyectile_direction(-1,1)
		elif Input.is_action_pressed("move_up"):
			projectile.set_proyectile_direction(0,-1)
		elif Input.is_action_pressed("move_down"):
			projectile.set_proyectile_direction(0,1)
		else:
			projectile.set_projectile_direction_y(0)

func restart_timer():
	timer.set_wait_time(timerWait)
	timer.start()

func _on_HandgunTimer_timeout():
	timer.stop()

func damage_loop():
	for body in get_node("hitbox").get_overlapping_bodies():
		if timer2.is_stopped() and ((body.get("TYPE") == "ENEMY") or (body.get("TYPE") == "FLYINGENEMY")):
			receive_damage()
		#elif health < 1:

func boost():
	match health:
		1:
			_change_life(1000, -1000, 0.1)
			_change_collition(false,true,true,true,true)
			_change_sprite(false,false,false,false)
		2:
			_change_life(800, -900, 0.2)
			_change_collition(true,false,true,true,true)
			_change_sprite(true,false,false,false)
		3:
			_change_life(600, -750, 0.3)
			_change_collition(true,true,false,true,true)
			_change_sprite(true,true,false,false)
		4:
			_change_life(500, -650, 0.4)
			_change_collition(true,true,true,false,true)
			_change_sprite(true,true,true,false)
		5:
			_change_life(200, -250, 0.5)
			_change_collition(true,true,true,true,false)
			_change_sprite(true,true,true,true)
		_:
			pass
			
func _change_collition(h1,h2,h3,h4,h5):
	$health1.set_disabled(h1)
	$health2.set_disabled(h2)
	$health3.set_disabled(h3)
	$health4.set_disabled(h4)
	$health5.set_disabled(h5)
	
func _change_sprite(s1,s2,s3,s4):
	$Node2D/Sprite.set_visible(s1)
	$Node2D/Sprite2.set_visible(s2)
	$Node2D/Sprite3.set_visible(s3)
	$Node2D/Sprite4.set_visible(s4)
func _change_life(speed, jump, timer):
	move_speed = speed
	jump_velocity = jump
	timerWait = timer

func on_projectile_hit(damage):
	if timer2.is_stopped():
		receive_damage()
	
func receive_damage():
	$AudioStreamPlayer.play()
	$Particles2D.emitting = true
	timer2.start()
	health -= 1
	call_deferred("boost")
	

func _on_Timer_timeout():
	timer2.stop()

func _on_StaticBody2D2_repel():
	receive_damage()
	velocity.y = -1500
	
func cure():
	health += 1
	call_deferred("boost")
	
func die():
	emit_signal("player_died")
	$playerSprite.visible = false
	$AnimationPlayer.play("Nueva animación")

func _on_AnimationPlayer_animation_finished(anim_name):
	call_deferred('queue_free')
