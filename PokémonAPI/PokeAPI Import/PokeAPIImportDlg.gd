extends Tabs

const Ability = preload("res://Source/Ability.gd")

var dir
var base_url
var json
var request_result

func _ready():
	$DestinationDirectory.text = $DirectoryDialog.current_dir

func _on_Button_pressed():
	$DirectoryDialog.popup_centered()

func _on_Import_pressed():
	var success = false
	base_url = $BaseURL.text
	dir = Directory.new()
	if dir.open($DestinationDirectory.text) == 0:
		#yield(import_abilities(), "completed")
		
		yield($AbilitiesImporter.import(base_url, $DestinationDirectory.text), "completed")
	else:
		do_log("Directory not found: " + $DestinationDirectory.text)
	if success:
		pass
	else:
		do_log("Import cancelled")

func _on_DirectoryDialog_dir_selected(dir):
	$DestinationDirectory.text = dir

func import_abilities():
	var abilities_dir = $DestinationDirectory.text + "/Abilities"
	if !dir.dir_exists(abilities_dir):
		dir.make_dir(abilities_dir)
	yield(do_request("ability"), "completed")
	if json.result != null:
		var count = json.result["count"]
		for i in count - 1:
			yield(do_request("ability/" + str(i + 1)), "completed")
			if json.result != null:
				var name = json.result["name"]
				var file = File.new()
				var ability
				var ability_node
				var path = abilities_dir + "/" + name + ".tscn"
				if file.file_exists(path):
					ability = load(path)
					ability_node = ability.instance()
				else:
					ability = PackedScene.new()
					ability_node = Ability.new()
					ability_node.name = name
				ability_node.description = get_en_description(json.result["flavor_text_entries"])
				ability.pack(ability_node)
				ResourceSaver.save(path, ability)
			else:
				do_log("ability/" + str(i + 1) + " not found")

func get_en_description(entries):
	for i in entries.size() - 1:
		if entries[i]["language"]["name"] == "en":
			return entries[i]["flavor_text"]
		pass
	return ""

func do_request(url):
	var full_url = base_url + "/" + url
	$HTTPRequest.request(full_url, [], false)
	yield($HTTPRequest, "request_completed")
	if request_result != 0:
		do_log("Error requesting " + full_url + "! Error-Code " + request_result)
	pass

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	json = JSON.parse(body.get_string_from_utf8())
	request_result = result

func do_log(entry):
	$Log.text += entry + "\n"

