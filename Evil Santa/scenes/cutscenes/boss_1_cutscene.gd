extends Node2D

func _ready():
	$Timer.start()
	$AnimationPlayer.play("dialogue_animation")
	print("anime")


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/levels/boss_level_1_2.tscn")
