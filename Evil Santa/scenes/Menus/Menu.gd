extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	#This lets you control the menu with a keyboard!
	$VBoxContainer/StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Change to beginning scene on start button.
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/cutscenes/opening_cutscene.tscn")

#Switch to menu that explains the controls
func _on_controls_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Menus/Controls.tscn")

#Quit the game
func _on_quit_button_pressed():
	get_tree().quit()
