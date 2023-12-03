extends CollisionShape2D

signal chestOpened

var ASSAULTRIFLE: PackedScene = preload('res://scenes/player/weaponPickups/assaultRiflePickup.tscn')

func _on_player_open_chest():
	print("---------------------------")
	#chestOpened.emit()
	spawnWeaponPickup()
	queue_free()
	
func spawnWeaponPickup():
	if ASSAULTRIFLE:
		var rifle = ASSAULTRIFLE.instantiate()
		get_tree().current_scene.add_child(rifle)
		rifle.global_position = $Marker2D.global_position
	
