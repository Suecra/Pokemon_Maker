extends Node

const Textbox = preload("res://Common/Textboxes/Textbox.gd")

func _on_Button_button_down():
	var text = "Dies ist ein langer Text um zu sehen, ob die Textbox richtig funktioniert"
	yield($Textbox.display(text), "completed")
	pass
