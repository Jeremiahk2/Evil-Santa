extends CharacterBody2D


var ProjectilePath = preload('res://scenes/enemies/ElementalProjectile.tscn')
var speed = 100
var health = 50
var player = null
var Hero = null
var go = false
var player_inattack_zone = false
var attack_cooldown = true
var attack_range = false

func _physics_process(delta):
	
	
	deal_with_damage()
	if go && !attack_range:

		var vec = Vector2(position)
		var ang = vec.angle_to_point(player.position)
		velocity.y = sin(ang) * speed
		velocity.x = cos(ang) * speed
		move_and_slide()
	
	if go && attack_range:
		if player != null && attack_cooldown:
			shoot()
			attack_cooldown = false
			$AttackTimer.start()
		
func _on_alert_body_entered(body):
	if body.has_method("player"):
		player = body
		go = true
		print("player detected")


func _on_alert_body_exited(body):
	if body.has_method("player"):
		player = null
		go = false
		attack_range = false


func _on_hit_box_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true
		Hero = body
		


func _on_hit_box_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = true
	
func deal_with_damage():
	if Hero != null && attack_cooldown:
		Hero.incoming_damage(15)
		attack_cooldown = false
		$AttackTimer.start()
		


func _on_attack_timer_timeout():
	attack_cooldown = true


func _on_range_body_entered(body):
	attack_range = true


func _on_range_body_exited(body):
	if !go:
		attack_range = false
		
	
func shoot():
	print("shoot")
	var projectile = ProjectilePath.instantiate()

	
	var vec = Vector2(position)
	var ang = vec.angle_to_point(player.position)
	projectile.velocity.y = sin(ang) * speed
	projectile.velocity.x = cos(ang) * speed
	var bullet_rotation = projectile.velocity.angle()
	projectile.rotation = bullet_rotation
	projectile.Hero = self.Hero
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = self.global_position
	
func incoming_damage(dmg):
	health = health - dmg
	print("damage taken = ")
	print(dmg)
	print(health)
	if health <= 0:
		self.queue_free()
		
func enemy():
	pass
