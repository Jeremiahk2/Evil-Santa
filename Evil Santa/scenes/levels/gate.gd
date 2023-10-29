extends StaticBody2D

signal player_entered_gate

func _on_area_2d_body_entered(_body):
	player_entered_gate.emit(_body)
