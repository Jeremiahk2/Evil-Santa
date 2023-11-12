extends Area2D

@onready var animation = $AnimationPlayer
signal assaultRiflePickedUp

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animation.play("ready")


func _on_area_entered(area):
	pass # Replace with function body.


func _on_body_entered(body):
	assaultRiflePickedUp.emit()
	queue_free()