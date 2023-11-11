extends Node2D

var BULLET: PackedScene = preload('res://scenes/player/playerBullet.tscn')

@onready var attackTimer = $attackTimer

@onready var animation = $AnimationPlayer

@onready var shooting = false

@onready var reloading = false

@onready var isAvailable = false

var shotsFired = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isAvailable:
		if shotsFired > 6 and !shooting:
			reloading = true
			animation.play("reload")
			await get_tree().create_timer(1.5).timeout
			shotsFired = 0
			reloading = false
		elif Input.is_action_pressed("left_click") and attackTimer.is_stopped() and !reloading:
			print("here1")
			shooting = true
			var bullet_direction = self.global_position.direction_to(get_global_mouse_position())
			animation.play("shoot")
			
			shoot_bullet(bullet_direction)
			await get_tree().create_timer(0.2).timeout
			shotsFired = shotsFired + 1
			shooting = false
		else:
			if !shooting && !reloading:
				print(attackTimer.is_stopped())
				animation.play("ready")
				
func trueAvailable():
	isAvailable = true
	
func falseAvailable():
	isAvailable = false
		
func shoot_bullet(bullet_direction: Vector2):
	if BULLET:
		var bullet = BULLET.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = $Marker2D.global_position
		
		var bullet_rotation = bullet_direction.angle()
		bullet.rotation = bullet_rotation
		
		attackTimer.start()
