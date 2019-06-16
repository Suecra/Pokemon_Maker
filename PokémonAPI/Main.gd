extends Node

const MessageBox = preload("res://Common/Textboxes/MessageBox.gd")
const PrioritySorter = preload("res://Source/Scripts/Battle/PrioritySorter.gd")

func _on_Button_button_down():
	$Test.current_hp = 70
	
	var text = "Er hörte leise Schritte hinter sich. Das bedeutete nichts Gutes. Wer würde ihm schon folgen, spät in der Nacht und dazu noch in dieser engen Gasse mitten im übel beleumundeten Hafenviertel? Gerade jetzt, wo er das Ding seines Lebens gedreht hatte und mit der Beute verschwinden wollte! Hatte einer seiner"
	$MessageBox.display_async(text)
	yield($MessageBox, "finsihed_display")
	$MessageBox.auto_skip = false
	yield($Choicebox.display(["Auswahl1", "Auswahl2"]), "completed")
	yield($MessageBox.display($Choicebox.selection), "completed")


func _on_Button2_button_down():
	var list = $TestNodes.get_children()
	PrioritySorter.sort2(list)
	for item in list:
		print(item.name)
