extends Node

export(String) var api_endpoint
export(String) var folder_name
var base_url
var destination
var json
var api_item_list
var api_item
var request_result
var directory
var result

func import(base_url, destination):
	self.base_url = base_url
	self.destination = destination
	directory = Directory.new()
	var directory_name = destination + "/" + folder_name
	if !directory.dir_exists(directory_name):
		directory.make_dir(directory_name)
	yield(do_request(api_endpoint + "?limit=9999"), "completed")
	api_item_list = json.result
	if api_item_list != null:
		var count = api_item_list["count"]
		var progress_bar = get_node("/root/Panel/TabContainer/API/ProgressBar")
		for i in count:
			yield(do_request(api_item_list["results"][i]["url"], true), "completed")
			api_item = json.result
			var name = _get_name()
			var file = File.new()
			var scene
			var item
			yield(_get_path(directory_name, name), "completed")
			var path = result
			if file.file_exists(path):
				scene = load(path)
				item = scene.instance()
			else:
				scene = PackedScene.new()
				item = _create_item()
				item.name = name
			yield(_import_item(item), "completed")
			scene.pack(item)
			ResourceSaver.save(path, scene)
			progress_bar.value = (i / count) * 100
		progress_bar.value = 0

func do_request(url, absolute = false):
	var full_url = url
	if !absolute:
		full_url = base_url + "/" + full_url
	var http_request = get_parent()
	http_request.request(full_url, ["User-Agent: Pirulo/1.0 (Godot)", "Accept: */*"], false)
	yield(http_request, "request_completed")
	if request_result != 0:
		do_log("Error requesting " + full_url + "! Error-Code " + request_result)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	json = JSON.parse(body.get_string_from_utf8())
	request_result = result

func do_log(entry):
	var l = get_node("/root/Panel/TabContainer/Api/Log")
	l.text += entry + "\n"

func _get_name():
	return api_item["name"]

func _get_path(directory_name, name):
	result = directory_name + "/" + name + ".tscn"
	yield(get_tree().create_timer(0), "timeout")

func get_en_description(entries, property_name):
	for i in entries.size():
		if entries[i]["language"]["name"] == "en":
			return entries[i][property_name]
	return ""

func _create_item():
	pass

func _import_item(item):
	pass