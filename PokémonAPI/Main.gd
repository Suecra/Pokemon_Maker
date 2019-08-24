extends Node

const MessageBox = preload("res://Common/Textboxes/MessageBox.gd")
const PrioritySorter = preload("res://Source/Scripts/Battle/PrioritySorter.gd")

func _on_Button_button_down():
	var text = "Er hörte leise Schritte hinter sich. Das bedeutete nichts Gutes. Wer würde ihm schon folgen, spät in der Nacht und dazu noch in dieser engen Gasse mitten im übel beleumundeten Hafenviertel? Gerade jetzt, wo er das Ding seines Lebens gedreht hatte und mit der Beute verschwinden wollte! Hatte einer seiner"
	yield($MessageBox.display(text), "completed")

func _on_Button2_button_down():
	var trainer = load("res://Scenes/TestTrainer.tscn").instance()
	var trainer2 = load("res://Scenes/TestTrainer2.tscn").instance()
	$Battle.add_ally_trainer(trainer)
	$Battle.add_opponent_trainer(trainer2)
	$Button.visible = false
	$Button2.visible = false
	$Battle.visible = true
	$Battle.start()
