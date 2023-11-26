extends CharacterBody2D



var Hero = null

func _process(delta):
	move_and_slide()


func _on_self_destruct_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		print("hit!")
		Hero = body
		deal_with_damage()
	self.queue_free()

func deal_with_damage():
	if Hero != null:
		print("element damage")
		Hero.incoming_damage(15)
		self.queue_free()
