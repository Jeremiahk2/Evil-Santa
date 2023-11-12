extends CharacterBody2D


var ProjectilePath = preload('res://scenes/enemies/BossDeerTwinLaser.tscn')
var ProjectilePath2 = preload('res://scenes/enemies/BossDeerSnowBall.tscn')
var speed = 100
var health = 50
var player = null
var Hero = null
var go = false
var player_inattack_zone = false
var attack_cooldown = true
var attack_range = false
var attack3 = false
var player_nearby = false
var can_attack = false
var init_timer = false

func _physics_process(delta):
	
	if player_nearby:
		look_at(Globals.player_pos)
		if can_attack:
			var attack = randi_range(0,2)
			if attack == 0:
				Attack_1()
			if attack == 1:
				Attack_2()
			if attack == 2:
				Attack_3()
			
			can_attack = false
			$AttackTimer.start()
		
	if !init_timer:
		$AttackTimer.start()
		init_timer = true
	
	
	
	
	
func Attack_1():
	print("shoot twin laser")
	var projectile = ProjectilePath.instantiate()

	
	var vec = Vector2(position)
	var ang = vec.angle_to_point(player.position)
	projectile.velocity.y = sin(ang) * speed
	projectile.velocity.x = cos(ang) * speed
	var bullet_rotation = projectile.velocity.angle()
	projectile.rotation = bullet_rotation
	projectile.Hero = self.Hero
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = $twinlaser1.global_position
	
	
	var projectile2 = ProjectilePath.instantiate()

	
	var vec2 = Vector2(position)
	var ang2 = vec2.angle_to_point(player.position)
	projectile2.velocity.y = sin(ang) * speed
	projectile2.velocity.x = cos(ang) * speed
	var bullet_rotation2 = projectile2.velocity.angle()
	projectile2.rotation = bullet_rotation2
	projectile2.Hero = self.Hero
	get_tree().current_scene.add_child(projectile2)
	projectile2.global_position = $twinlaser2.global_position
	
func Attack_2():
	var projectile2 = ProjectilePath2.instantiate()

	
	var vec2 = Vector2(position)
	var ang2 = vec2.angle_to_point(player.position)
	projectile2.velocity.y = sin(ang2) * 50
	projectile2.velocity.x = cos(ang2) * 50
	var bullet_rotation2 = projectile2.velocity.angle()
	projectile2.rotation = bullet_rotation2
	projectile2.Hero = self.Hero
	get_tree().current_scene.add_child(projectile2)
	projectile2.global_position = $snowball.global_position
	
	
func Attack_3():
	attack3 = true
	

func _on_attack_area_body_entered(body):
	player_nearby = true
	if body.has_method("player"):
		player_inattack_zone = true
		Hero = body
		player = Hero




func _on_attack_timer_timeout():
	can_attack = true
