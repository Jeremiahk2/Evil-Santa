extends LevelParent 

var chest_opened = false

func _on_player_enter_gate():
	print("pressed e")
	get_tree().change_scene_to_file("res://scenes/levels/inside.tscn")

func _on_player_open_chest():
	#print("pressed e")
	if !chest_opened:
		### get next weapon TODO ###
		print("opened")
		chest_opened = true
