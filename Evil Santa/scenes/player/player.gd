extends CharacterBody2D

@onready var all_interactions = []
@onready var interactLabel = $"HUD/InteractionLabel"
signal enter_gate
signal open_chest

@export var MAX_SPEED = 200
@export var ACCELERATION = 1500
@export var FRICTION = 1200
var health = 100
@export var axis = Vector2.ZERO
@export var projectileSpeed = 100
@onready var creditsLabel = $"HUD/CreditsLabel"

@onready var animation = $AnimationPlayer

var weapon = "No weapon"

var arr = ["No weapon", "No weapon", "No weapon"]

var currNumberOfWeapons = 0

var currWeapon = 0

var BULLET: PackedScene = preload('res://scenes/player/weapons/rifleBullet.tscn')

@onready var attackTimer = $AttackTimer

@onready var pistol = $pistol

@onready var assaultRifle = $assaultRifle

@onready var shotgun = $shotgun




func _ready():
	update_interactions()
	update_credits()
	pistol.visible = false
	pistol.falseAvailable()
	assaultRifle.visible = false
	assaultRifle.falseAvailable()
	shotgun.visible = false
	shotgun.falseAvailable()
	

func _physics_process(delta):
	#if the player is moving then play the running animation
	if velocity.length() > 0:
		animation.play("Run")
	else:
		animation.play("Idle")
		
	#move the player
	move(delta)
	
	if Input.is_action_just_pressed("Interact"):
		execute_interaction()
	
	#rotate the player to face the mouse
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("press_1") && (currNumberOfWeapons >= 1):
		currWeapon = 0
		weapon = arr[currWeapon]
		
	elif Input.is_action_just_pressed("press_2") && (currNumberOfWeapons >= 2):
		currWeapon = 1
		weapon = arr[currWeapon]
		
	elif Input.is_action_just_pressed("press_3") && (currNumberOfWeapons >= 3):
		currWeapon = 2
		weapon = arr[currWeapon]
	
	if weapon == "pistol":
		assaultRifle.visible = false
		assaultRifle.falseAvailable()
		shotgun.visible = false
		shotgun.falseAvailable()
		pistol.visible = true
		pistol.trueAvailable()
	elif weapon == "assaultRifle":
		pistol.visible = false
		pistol.falseAvailable()
		shotgun.visible = false
		shotgun.falseAvailable()
		assaultRifle.visible = true
		assaultRifle.trueAvailable()
	elif weapon == "shotgun":
		pistol.visible = false
		pistol.falseAvailable()
		assaultRifle.visible = false
		assaultRifle.falseAvailable()
		shotgun.visible = true
		shotgun.trueAvailable()
		
	
	#if weapon == "pistol":
		#if PISTOL:
			#var pistolGun = PISTOL.instantiate()
			#get_tree().current_scene.add_child(pistolGun)
			#pistolGun.global_position = $Marker2D.global_position
	
	#shoot when the player left-clicks and the weapon was not just shot (timer is currently .2s)
	#if Input.is_action_just_pressed("left_click") and attackTimer.is_stopped():
		#var bullet_direction = self.global_position.direction_to(get_global_mouse_position())
		#shoot_bullet(bullet_direction)
	
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
	Globals.health = Globals.health - dmg
	$"HUD/Health Bar/Health Bar".update_health(Globals.health / 10.0)
	if Globals.health <= 0:
		get_tree().change_scene_to_file("res://scenes/Menus/DeathScreen.tscn")
	
	
#func shoot_bullet(bullet_direction: Vector2):
	#if BULLET:
		#var bullet = BULLET.instantiate()
		#get_tree().current_scene.add_child(bullet)
		#bullet.global_position = $Marker2D.global_position
		
		#var bullet_rotation = bullet_direction.angle()
		#bullet.rotation = bullet_rotation
		
		#attackTimer.start()

############## Interaction  Methods #################

func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()


func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		#interactLabel.global_position = all_interactions[0].global_position
		#interactLabel.global_position.y -= 5
		#interactLabel.global_position.x -= 30
		interactLabel.text = all_interactions[0].interact_label
		interactLabel.show()
	else:
		interactLabel.hide()


func execute_interaction():
	if all_interactions:
		var cur_interaction = all_interactions[0]
		match cur_interaction.interact_type:
			"print_text": 
				print(cur_interaction.interact_value)
			"gate":
				print(cur_interaction.interact_value)
				enter_gate.emit() 
			"chest":
				print(cur_interaction.interact_value)
				open_chest.emit()
				### TODO ###
#credits
func update_credits():
	creditsLabel.text = "Credits: " + str(Globals.credits)

func increase_credits(numCredits):
	Globals.credits += numCredits


func _on_pistol_pickup_pistol_picked_up():
	arr[currNumberOfWeapons] = "pistol"
	currWeapon = currNumberOfWeapons
	weapon = arr[currWeapon]
	currNumberOfWeapons = currNumberOfWeapons + 1


func _on_assault_rifle_pickup_assault_rifle_picked_up():
	arr[currNumberOfWeapons] = "assaultRifle"
	currWeapon = currNumberOfWeapons
	weapon = arr[currWeapon]
	currNumberOfWeapons = currNumberOfWeapons + 1


func _on_shotgun_pickup_shotgun_picked_up():
	arr[currNumberOfWeapons] = "shotgun"
	currWeapon = currNumberOfWeapons
	weapon = arr[currWeapon]
	currNumberOfWeapons = currNumberOfWeapons + 1
