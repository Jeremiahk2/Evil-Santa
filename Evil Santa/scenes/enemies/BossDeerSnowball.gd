extends CharacterBody2D

var speed = 10


var health = 50
var player = null
var Hero = null
var go = false
var player_inattack_zone = false
var attack_cooldown = true
var clock_started = false

func _physics_process(delta):
	
	if !clock_started:
		$Death.start()
		clock_started = true
	
	move_and_slide()
	




func _on_hit_box_body_entered(body):
	print("hit!")
	if body.has_method("player"):
		player_inattack_zone = true
		Hero = body
		deal_with_damage()
	
	if !body.has_method("BossLaser"):
		self.queue_free()


func _on_hit_box_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = true
	
func deal_with_damage():
	if Hero != null:
		print("element damage")
		Hero.incoming_damage(15)
		self.queue_free()
		


func _on_attack_timer_timeout():
	attack_cooldown = true

func incoming_damage(dmg):
	health = health - dmg
	print("damage taken = ")
	print(dmg)
	print(health)
	if health <= 0:
		self.queue_free()


func _on_alert_body_entered(body):
	
	if body.has_method("player"):
		print("hit!")
		player_inattack_zone = true
		Hero = body
		deal_with_damage()


func _on_alert_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_death_timeout():
	self.queue_free()

