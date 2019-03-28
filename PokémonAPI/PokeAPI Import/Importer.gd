extends Node

export(String) var api_endpoint
export(String) var folder_name
var base_url
var json
var request_result
var count

func import(base_url, destination):
	self.base_url = base_url
	var dir = Directory.new()
	var directory = destination + "/" + folder_name
	if !dir.dir_exists(directory):
		dir.make_dir(directory)
	yield(get_count(), "completed")
	yield(do_request(api_endpoint + "/?limit=" + str(count)), "completed")
	if json.result != null:
		print(json.result)
		for i in count - 1:
			#yield(do_request(api_endpoint + "/" + str(i + 1)), "completed")
			var dict = json.result["results"][i + 1]
			var name = dict["name"]
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
			_import_item(item, dict)
			scene.pack(item)
			ResourceSaver.save(path, scene)
			get_parent().get_node("ProgressBar").value = i / count * 100
	pass

func do_request(url):
	var full_url = base_url + "/" + url
	var http_request = get_parent().get_node("HTTPRequest")
	http_request.request(full_url, [], false)
	yield(http_request, "request_completed")
	if request_result != 0:
		do_log("Error requesting " + full_url + "! Error-Code " + request_result)
	pass

func get_count():
	yield(do_request(api_endpoint + "/?limit=1"), "completed")
	count = json.result["count"]

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