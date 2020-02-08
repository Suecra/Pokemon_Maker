extends Control

export(String) var text setget set_text
export(int) var value setget set_value, get_value
export(int) var min_value setget set_min_value
export(int) var max_value setget set_max_value

func set_text(val):
	$Label.text = val
	text = val

func set_value(val):
	if val != value:
		$Slider.value = val
		value = $Slider.value
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
	$LineEdit.text = str(val)

func _on_LineEdit_text_entered(new_text):
	$Slider.value = new_text.to_int()
