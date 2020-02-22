extends Control

export(String) var text setget set_text
export(int) var value setget set_value, get_value
export(int) var min_value setget set_min_value
export(int) var max_value setget set_max_value

var do_update_text = true

func set_text(val):
	$Label.text = val
	text = val

func set_value(val):
	$Slider.value = val
	value = $Slider.value
	if do_update_text:
		$LineEdit.text = str(value)

func set_min_value(val):
	min_value = val
	$Slider.min_value = val

func set_max_value(val):
	max_value = val
	$Slider.max_value = val

func get_value():
	return $Slider.value

func _on_Slider_value_changed(val):
	if do_update_text:
		$LineEdit.text = str(val)

func _on_LineEdit_text_entered(new_text):
	do_update_text = false
	$Slider.value = new_text.to_int()
	value = $Slider.value
	do_update_text = true

func _on_LineEdit_text_changed(new_text):
	do_update_text = false
	$Slider.value = new_text.to_int()
	value = $Slider.value
	do_update_text = true

func _ready():
	$LineEdit.text = str(value)