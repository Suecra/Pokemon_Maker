extends Node

const MessageBox = preload("res://Common/Textboxes/MessageBox.gd")
const PrioritySorter = preload("res://Source/Scripts/Battle/PrioritySorter.gd")

func _on_Button2_button_down():
	var trainer = load("res://Scenes/Trainer/TestTrainer.tscn").instance()
	var trainer2 = load("res://Scenes/Trainer/TestTrainer2.tscn").instance()
	$Battle.add_ally_trainer(trainer)
	$Battle.add_opponent_trainer(trainer2)
	$Button2.visible = false
	$Battle.visible = true
	yield($Battle.start(), "completed")
	$Battle.visible = false
	$Button2.visible = true

func _ready():
	randomize()