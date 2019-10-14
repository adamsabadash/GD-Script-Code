extends Node

func _unhandled_input(event):
	if event is InputEventKey:
		#Creates quit function
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()