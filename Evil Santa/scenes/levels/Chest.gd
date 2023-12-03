extends CollisionShape2D

signal chestOpened

var SHOTGUN: PackedScene = preload('res://scenes/player/weaponPickups/shotgunPickup.tscn')

func _on_player_open_chest():
	print("---------------------------")
	#chestOpened.emit()
	spawnWeaponPickup()
	queue_free()
	
func spawnWeaponPickup():
	if SHOTGUN:
		var shotgun = SHOTGUN.instantiate()
		get_tree().current_scene.add_child(shotgun)
		shotgun.global_position = $Marker2D.global_position
	
