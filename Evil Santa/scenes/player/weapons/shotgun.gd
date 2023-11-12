extends Node2D

var BULLET: PackedScene = preload('res://scenes/player/weapons/shotgunPellet.tscn')

@onready var attackTimer = $attackTimer

@onready var animation = $AnimationPlayer

@onready var shooting = false

@onready var isAvailable = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isAvailable:
		if Input.is_action_just_pressed("left_click") and attackTimer.is_stopped():
			shooting = true
			var bullet_direction = self.global_position.direction_to(get_global_mouse_position())
			animation.play("shoot")
			
			shoot_bullet(bullet_direction)
			await get_tree().create_timer(2.0).timeout
			shooting = false
		else:
			if !shooting:
				animation.play("ready")
				
func trueAvailable():
	isAvailable = true
	
func falseAvailable():
	isAvailable = false
		
func shoot_bullet(bullet_direction: Vector2):
	if BULLET:
		var bullet_rotation = bullet_direction.angle()
		
		var bullet1 = BULLET.instantiate()
		get_tree().current_scene.add_child(bullet1)
		bullet1.global_position = $Marker2D.global_position
		bullet1.rotation = bullet_rotation
		
		var bullet2 = BULLET.instantiate()
		get_tree().current_scene.add_child(bullet2)
		bullet2.global_position = $Marker2D.global_position
		bullet2.rotation = bullet_rotation - .2
		
		var bullet3 = BULLET.instantiate()
		get_tree().current_scene.add_child(bullet3)
		bullet3.global_position = $Marker2D.global_position
		bullet3.rotation = bullet_rotation - .1
		
		var bullet4 = BULLET.instantiate()
		get_tree().current_scene.add_child(bullet4)
		bullet4.global_position = $Marker2D.global_position
		bullet4.rotation = bullet_rotation + .1
		
		var bullet5 = BULLET.instantiate()
		get_tree().current_scene.add_child(bullet5)
		bullet5.global_position = $Marker2D.global_position
		bullet5.rotation = bullet_rotation + .2
		
		attackTimer.start()
