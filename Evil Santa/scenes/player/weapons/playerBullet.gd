extends Area2D

@export var SPEED: int = 300

var POOF: PackedScene = preload('res://scenes/projectiles/poofAnimation.tscn')

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += SPEED * direction * delta
	
func destroy():
	var poof = POOF.instantiate()
	get_tree().current_scene.add_child(poof)
	poof.global_position = $Sprite2D.global_position
	queue_free()


func _on_area_entered(_area):
	destroy()


func _on_body_entered(_body):
	if _body.has_method("enemy"):
		_body.incoming_damage(20)
	destroy()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
