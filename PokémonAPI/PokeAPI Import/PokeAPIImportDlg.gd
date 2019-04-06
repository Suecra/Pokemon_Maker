extends Tabs

var dir
var base_url

func _ready():
	$DestinationDirectory.text = $DirectoryDialog.current_dir

func _on_Button_pressed():
	$DirectoryDialog.popup_centered()

func _on_Import_pressed():
	var success = false
	base_url = $BaseURL.text
	dir = Directory.new()
	if dir.open($DestinationDirectory.text) == 0:
		#yield($AbilityImporter.import(base_url, $DestinationDirectory.text), "completed")
		#yield($ItemImporter.import(base_url, $DestinationDirectory.text), "completed")
		#yield($BerryImporter.import(base_url, $DestinationDirectory.text), "completed")
		#yield($TypeImporter.import(base_url, $DestinationDirectory.text), "completed")
		#yield($HTTPRequest/ContestEffectImporter.import(base_url, $DestinationDirectory.text), "completed")
		yield($HTTPRequest/NatureImporter.import(base_url, $DestinationDirectory.text), "completed")
		pass
	else:
		do_log("Directory not found: " + $DestinationDirectory.text)
	if success:
		pass
	else:
		do_log("Import cancelled")

func _on_DirectoryDialog_dir_selected(dir):
	$DestinationDirectory.text = dir

func do_log(entry):
	$Log.text += entry + "\n"

