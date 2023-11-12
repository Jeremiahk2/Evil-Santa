extends CharacterBody2D

var speed = 100
var health = 750
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
	look_at(Globals.player_pos)
	
	if go && !attack_range:
		look_at(Globals.player_pos)
		var vec = Vector2(position)
		var ang = vec.angle_to_point(player.position)
		velocity.y = sin(ang) * speed
		velocity.x = cos(ang) * speed
		move_and_slide()
	
	if go && attack_range:
		look_at(Globals.player_pos)
		if player != null && attack_cooldown:
			player.incoming_damage(15)
			attack_cooldown = false
			go = false
			$PhysicalAttack.start()
			
			
	
	
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
	var attack = randi_range(1,6)
	var attack2 = randi_range(1,6)
	var strAttack = str(attack)
	var strAttack2 = str(attack2)
	strAttack = "BombSpawner" + strAttack
	strAttack2 = "BombSpawner" + strAttack2
	var temp = get_tree().current_scene.get_node(strAttack)
	var temp2 = get_tree().current_scene.get_node(strAttack2)
	temp.spawn()
	temp2.spawn()
	
	if health < 200:
		var attack3 = randi_range(1,6)

		var strAttack3 = str(attack3)

		strAttack3 = "BombSpawner" + strAttack3

		var temp3 = get_tree().current_scene.get_node(strAttack3)

		temp3.spawn()
	
func Attack_2():
	pass
	
	
func Attack_3():
	attack3 = true
	

func _on_attack_area_body_entered(body):
	
	if body.has_method("player"):
		player = body
		go = true
		player_nearby = true


func _on_attack_area_body_exited(body):
	player_nearby = false


func _on_attack_timer_timeout():
	can_attack = true



func _on_range_body_entered(body):
	if body.has_method("player"):
		print("in range")
		attack_range = true
		go = true


func _on_range_body_exited(body):
	if body.has_method("player"):
		attack_range = false


func _on_physical_attack_timeout():
	attack_cooldown = true
	go = true
	
func incoming_damage(dmg):
	health = health - dmg
	print("damage taken = ")
	print(dmg)
	print(health)
	if health <= 0:
		self.queue_free()
		
func enemy():
	pass
