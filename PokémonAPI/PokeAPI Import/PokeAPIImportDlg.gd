extends Tabs

var dir
var base_url
var edit

func _ready():
	$DestinationDirectory.text = $DirectoryDialog.current_dir

func _on_Import_pressed():
	var success = false
	base_url = $BaseURL.text
	dir = Directory.new()
	var importer_list = $HTTPRequest.get_children()
	if dir.open($DestinationDirectory.text) == 0:
		for importer in importer_list:
			if importer.enabled:
				yield(importer.import(base_url, $DestinationDirectory.text), "completed")
	else:
		do_log("Directory not found: " + $DestinationDirectory.text)
	if success:
		pass
	else:
		do_log("Import cancelled")

func _on_DirectoryDialog_dir_selected(dir):
	edit.text = dir

func do_log(entry):
	$Log.text += entry + "\n"