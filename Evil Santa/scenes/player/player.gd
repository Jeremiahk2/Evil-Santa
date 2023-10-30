extends CharacterBody2D

@export var MAX_SPEED = 200
@export var ACCELERATION = 1500
@export var FRICTION = 1200
var health = 100
@export var axis = Vector2.ZERO

@onready var animation = $AnimationPlayer

func _physics_process(delta):
	if velocity.length() > 0:
		animation.play("Run")
	else:
		animation.play("Idle")
	move(delta)
	look_at(get_global_mouse_position())
	
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
