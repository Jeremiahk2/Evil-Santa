extends CollisionShape2D

signal chestOpened

func _on_player_open_chest():
	print("---------------------------")
	chestOpened.emit()
	queue_free()
