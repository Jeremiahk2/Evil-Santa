extends LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")

func _ready():
	for deer in get_tree().get_nodes_in_group("Deers"):
		deer.connect('laser', _on_deer_laser)

func _on_gate_player_entered_gate(_body):
	#var tween = create_tween()
	#tween.tween_property($Player, "speed",0,0.5)
	get_tree().change_scene_to_file("res://scenes/levels/inside.tscn")

func _on_deer_laser(pos, direction):
	create_laser(pos, direction)
func create_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)
