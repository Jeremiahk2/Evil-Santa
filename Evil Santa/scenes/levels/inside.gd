extends LevelParent 

var chest_opened = false

@onready var shotgun = $shotgunPickup


func _on_player_enter_gate():
	#print("pressed e")
	get_tree().change_scene_to_file("res://scenes/levels/final_boss.tscn")


func _on_player_open_chest():
	#print("pressed e")
	if !chest_opened:
		### get next weapon TODO ###
		print("opened")
		chest_opened = true



func _on_chest_chest_opened():
	print("made it")
	shotgun.visible = true


func _on_ready():
	shotgun.visible = false
