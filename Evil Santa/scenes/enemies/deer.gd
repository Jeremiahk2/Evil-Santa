extends CharacterBody2D


var ProjectilePath = preload('res://scenes/projectiles/laser.tscn')
var health = 50
var player_nearby: bool = false
var can_laser: bool = true
var Hero = null
signal laser(pos, direction)


func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var projectile = ProjectilePath.instantiate()
			var vec = Vector2(position)
			var ang = vec.angle_to_point(Hero.position)
			projectile.velocity.y = sin(ang) * 100
			projectile.velocity.x = cos(ang) * 100
			var bullet_rotation = projectile.velocity.angle() + deg_to_rad(90)
			projectile.rotation = bullet_rotation
			projectile.Hero = self.Hero
			get_tree().current_scene.add_child(projectile)
			projectile.global_position = $NoseLaserSpawn.global_position
			can_laser = false
			$NoseLaserCooldown.start()
\
	

func _on_attack_area_body_entered(_body):
	player_nearby = true
	$NoseLaserCooldown.start()
	if _body.has_method("player"):
		Hero = _body


func _on_attack_area_body_exited(_body):
	player_nearby = false


func _on_nose_laser_cooldown_timeout():
	can_laser = true
	
func incoming_damage(dmg):
	health = health - dmg
	print("damage taken = ")
	print(dmg)
	print(health)
	if health <= 0:
		self.queue_free()
		
func enemy():
	pass
