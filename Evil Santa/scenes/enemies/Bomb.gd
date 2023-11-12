extends CharacterBody2D



func _physics_process(delta):
	self.velocity.y = 100
	move_and_slide()
	


func _on_explosion_body_entered(body):
	
	if body.has_method("player"):
		body.incoming_damage(15)
		self.queue_free()
