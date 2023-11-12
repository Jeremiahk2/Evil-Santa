extends Node2D


@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	animation.play("RESET")
	await get_tree().create_timer(0.5).timeout
	queue_free()


