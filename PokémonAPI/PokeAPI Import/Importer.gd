extends Node

export(String) var api_endpoint
export(String) var folder_name
var base_url
var json
var api_item_list
var request_result

func import(base_url, destination):
	self.base_url = base_url
	var dir = Directory.new()
	var directory = destination + "/" + folder_name
	if !dir.dir_exists(directory):
		dir.make_dir(directory)
	yield(do_request(api_endpoint + "/?limit=9999"), "completed")
	api_item_list = json.result
	if api_item_list != null:
		var count = api_item_list["count"]
		for i in count - 1:
			yield(do_request(api_item_list["results"][i]["url"], true), "completed")
			var api_item = json.result
			var name = api_item["name"]
			var file = File.new()
			var scene
			var item
			var path = directory + "/" + name + ".tscn"
			if file.file_exists(path):
				scene = load(path)
				item = scene.instance()
			else:
				scene = PackedScene.new()
				item = _create_item()
				item.name = name
			_import_item(item, api_item)
			scene.pack(item)
			ResourceSaver.save(path, scene)
			get_parent().get_node("ProgressBar").value = (i / count) * 100
	pass

func do_request(url, absolute = false):
	var full_url = url
	if !absolute:
		full_url = base_url + "/" + full_url
	var http_request = get_parent().get_node("HTTPRequest")
	http_request.request(full_url, ["User-Agent: Pirulo/1.0 (Godot)", "Accept: */*"], false)
	yield(http_request, "request_completed")
	if request_result != 0:
		do_log("Error requesting " + full_url + "! Error-Code " + request_result)
	pass

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	json = JSON.parse(body.get_string_from_utf8())
	request_result = result

func do_log(entry):
	var l = get_parent().get_node("Log")
	l.text += entry + "\n"

func _create_item():
	pass

func _import_item(item):
	pass