extends CharacterBody2D

@export var MAX_SPEED = 200
@export var ACCELERATION = 1500
@export var FRICTION = 1200
var health = 100
@export var axis = Vector2.ZERO
@export var projectileSpeed = 100

@onready var animation = $AnimationPlayer

var BULLET: PackedScene = preload('res://scenes/player/playerBullet.tscn')

@onready var attackTimer = $AttackTimer

func _physics_process(delta):
	#if the player is moving then play the running animation
	if velocity.length() > 0:
		animation.play("Run")
	else:
		animation.play("Idle")
		
	#move the player
	move(delta)
	
	#rotate the player to face the mouse
	look_at(get_global_mouse_position())
	
	#shoot when the player left-clicks and the weapon was not just shot (timer is currently .2s)
	if Input.is_action_just_pressed("left_click") and attackTimer.is_stopped():
		var bullet_direction = self.global_position.direction_to(get_global_mouse_position())
		shoot_bullet(bullet_direction)
	
func get_input_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis.normalized()

func move(delta):
	axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta) #apply friction
		
	else:
		apply_movement(axis * ACCELERATION * delta) #apply movement
	move_and_slide()
	Globals.player_pos = global_position

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
		
	else:
		velocity = Vector2.ZERO
		
func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(MAX_SPEED)

func player():
	pass
	
func incoming_damage(dmg):
	health = health - dmg
	print(health)
	if health <= 0:
		self.queue_free()
	
func shoot_bullet(bullet_direction: Vector2):
	if BULLET:
		var bullet = BULLET.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = $Marker2D.global_position
		
		var bullet_rotation = bullet_direction.angle()
		bullet.rotation = bullet_rotation
		
		attackTimer.start()
