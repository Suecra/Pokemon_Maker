extends Node

const Textbox = preload("res://Common/Textboxes/Textbox.gd")

func _on_Button_button_down():
	var text = "Er hörte leise Schritte hinter sich. Das bedeutete nichts Gutes. Wer würde ihm schon folgen, spät in der Nacht und dazu noch in dieser engen Gasse mitten im übel beleumundeten Hafenviertel? Gerade jetzt, wo er das Ding seines Lebens gedreht hatte und mit der Beute verschwinden wollte! Hatte einer seiner"
	yield($Textbox.display(text), "completed")
	pass
