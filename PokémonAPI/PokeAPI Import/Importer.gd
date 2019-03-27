extends Node

export(String) var api_endpoint
export(String) var folder_name
var base_url
var json
var request_result

func import(base_url, destination):
	self.base_url = base_url
	var dir = Directory.new()
	var directory = destination + "/" + folder_name
	if !dir.dir_exists(directory):
		dir.make_dir(directory)
	yield(do_request("ability"), "completed")
	if json.result != null:
		var count = json.result["count"]
		print(json.result)
		for i in count - 1:
			yield(do_request(api_endpoint + "/" + str(i + 1)), "completed")
			if json.result != null:
				var name = json.result["name"]
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
				_import_item(item)
				scene.pack(item)
				ResourceSaver.save(path, scene)
				get_parent().get_node("ProgressBar").value = i / count * 100
			else:
				do_log("ability/" + str(i + 1) + " not found")
	pass

func do_request(url):
	var full_url = base_url + "/" + url
	var http_request = get_parent().get_node("HTTPRequest")
	http_request.request(full_url, [], false)
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