extends Area2D

@onready var animation = $AnimationPlayer
signal assaultRiflePickedUp

var withinRange = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animation.play("ready")
	if(Input.is_action_pressed("Interact") && withinRange):
		#assaultRiflePickedUp.emit()
		Globals.arr[Globals.currNumberOfWeapons] = "assaultRifle"
		Globals.currWeapon = Globals.currNumberOfWeapons
		Globals.weapon = Globals.arr[Globals.currWeapon]
		Globals.currNumberOfWeapons = Globals.currNumberOfWeapons + 1
		queue_free()


func _on_area_entered(area):
	pass # Replace with function body.


func _on_body_entered(body):
	withinRange = true


func _on_body_exited(body):
	withinRange = false
