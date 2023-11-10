extends HBoxContainer

enum MODES {simple, empty, partial}
@export var mode : MODES = MODES.partial

var heart_full = preload("res://assets/hud_heartFull.png")
var heart_empty = preload("res://assets/hud_heartEmpty.png")
var heart_half = preload("res://assets/hud_heartHalf.png")


func update_health(value):
	match mode:
		MODES.simple:
			update_simple(value)
		MODES.empty:
			update_empty(value)
		MODES.partial:
			update_partial(value)

#Not used but we can if we want.
func update_simple(value):
	for i in get_child_count():
		get_child(i).visible = value > i
#Same here.
func update_empty(value):
	for i in get_child_count():
		if value > i:
			get_child(i).texture = heart_full
		else:
			get_child(i).texture = heart_empty
#Currently active. Change mode to switch versions.
func update_partial(value):
	for i in get_child_count():
		if value >= i + 1:
			print (value)
			get_child(i).texture = heart_full
		elif value > i:
			get_child(i).texture = heart_half
		else:
			get_child(i).texture = heart_empty
