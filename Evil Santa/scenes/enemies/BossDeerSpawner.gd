extends Marker2D


var DeerPath = preload('res://scenes/enemies/deer.tscn')

@export var small_timer_randomization: bool = false

@export var spawn_interval = 5
var actual_spawn_interval = spawn_interval
var timer = 0
var child_alive = false
var temp = null
func _ready():
	if small_timer_randomization == true:
		actual_spawn_interval = spawn_interval + randf_range(-0.75, 0.75)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	# Handle spawning
	var Boss = get_tree().current_scene.get_node("Boss Deer")
	if is_instance_valid(Boss) && timer >= actual_spawn_interval - 1 && Boss.attack3 && !is_instance_valid(temp):
		
		Boss.attack3 = false
		spawn()

func spawn():
	var Boss = get_tree().current_scene.get_node("Boss Deer")
	
	if is_instance_valid(Boss):
		timer = 0
		temp = DeerPath.instantiate()
	# The randomization at the end is so that way the collisions don't go fucky wucky

<<<<<<< HEAD
	get_tree().current_scene.add_child(temp)
	temp.global_position = self.global_position
	if small_timer_randomization == true:
		actual_spawn_interval = spawn_interval + randf_range(-0.75, 0.75)
<<<<<<< HEAD
<<<<<<< HEAD

#when boss dies
func _on_boss_deer_boss_death():
	queue_free()
=======
		get_tree().current_scene.add_child(temp)
		temp.global_position = self.global_position
		if small_timer_randomization == true:
			actual_spawn_interval = spawn_interval + randf_range(-0.75, 0.75)
		child_alive = true
>>>>>>> 258092eb8f4dbd8e98e92d010d65741a0f985575
=======
>>>>>>> parent of 49e5255 (added cutscene.)
=======
>>>>>>> parent of 49e5255 (added cutscene.)
