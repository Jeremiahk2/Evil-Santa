extends Node2D

func _ready():
	$Timer.start()
	$AnimationPlayer.play("dialogue_animation")

func _input(event):
	if (event.is_action_pressed("ui_cancel")):
		get_tree().change_scene_to_file("res://scenes/levels/boss_level_1_2.tscn")

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/levels/boss_level_1_2.tscn")
