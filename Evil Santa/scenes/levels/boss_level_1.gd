extends LevelParent 

signal remove_wall

var chest_opened = false


func _on_boss_deer_boss_death():
	get_tree().change_scene_to_file("res://scenes/cutscenes/boss_1_cutscene.tscn")
	remove_wall.emit()
