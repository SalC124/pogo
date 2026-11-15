extends Button

signal start_button_pressed

func _pressed():
	start_button_pressed.emit()
	disabled = true
	visible = false
	print("PLASDEF (1)")
