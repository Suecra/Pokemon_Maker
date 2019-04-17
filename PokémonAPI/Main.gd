extends Node

const Textbox = preload("res://Common/Textboxes/Textbox.gd")

func _on_Button_button_down():
	$Textbox.display("Hallo Welt")
	pass
