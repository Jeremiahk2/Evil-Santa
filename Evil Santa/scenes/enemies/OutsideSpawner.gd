extends Marker2D


var ElfPath = preload('res://scenes/enemies/Elf.tscn')

@export var small_timer_randomization: bool = false

@export var spawn_interval = 5
var actual_spawn_interval = spawn_interval
var timer = 0

func _ready():
	if small_timer_randomization == true:
		actual_spawn_interval = spawn_interval + randf_range(-0.75, 0.75)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	# Handle spawning
	print("spawning?")
	if timer >= actual_spawn_interval - 1:
		print("spawn!")
		spawn()

func spawn():
	timer = 0
	var temp = ElfPath.instantiate()
	# The randomization at the end is so that way the collisions don't go fucky wucky

	get_tree().current_scene.add_child(temp)
	temp.global_position = self.global_position
	if small_timer_randomization == true:
		actual_spawn_interval = spawn_interval + randf_range(-0.75, 0.75)
