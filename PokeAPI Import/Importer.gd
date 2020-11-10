extends Node

export(String) var api_endpoint
export(String) var folder_name
export(bool) var enabled = true
export(int) var max_amount = -1
export(int) var offset = 0
export(String) var file_type

var base_url
var destination
var json
var api_item_list
var api_item
var request_result
var directory
var result
var path
var scene
var item

func import(base_url, destination):
	self.base_url = base_url
	self.destination = destination
	directory = Directory.new()
	var directory_name = destination + "/" + folder_name
	if !directory.dir_exists(directory_name):
		directory.make_dir(directory_name)
	yield(do_request(api_endpoint + "?limit=9999&offset=" + str(offset)), "completed")
	api_item_list = json.result
	if api_item_list != null:
		var count = api_item_list["count"]
		if max_amount > -1:
			count = min(count, max_amount)
		var progress_bar = get_node("/root/Panel/TabContainer/API/ProgressBar")
		_before_import()
		for i in count:
			yield(do_request(api_item_list["results"][i]["url"], true), "completed")
			api_item = json.result
			var name = _get_name()
			yield(_get_path(directory_name, name), "completed")
			path = result
			_load()
			_on_import_item()
			yield(_import_item(), "completed")
			_save()
			progress_bar.value = (i / count) * 100
		progress_bar.value = 0
		_after_import()

func _load() -> void:
	var file = File.new()
	if file.file_exists(path):
		scene = load(path)
		item = scene.instance()
	else:
		scene = PackedScene.new()
		item = _create_item()
		item.name = name

func _save() -> void:
	scene.pack(item)
	ResourceSaver.save(path, scene)

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
	var api = get_node("/root/Panel/TabContainer/API")
	api.do_log(entry)

func _get_name():
	return api_item["name"]

func _get_path(directory_name, name):
	result = directory_name + "/" + name + "." + file_type
	yield(get_tree().create_timer(0), "timeout")

func get_en_description(entries, property_name):
	for i in entries.size():
		if entries[i]["language"]["name"] == "en":
			return entries[i][property_name]
	return ""

func get_or_add_node(parent: Node, name: String):
	var node
	if parent.has_node(name):
		node = parent.get_node(name)
	else:
		node = Node.new()
		node.name = name
		parent.add_child(node)
		node.owner = parent
	return node

func _before_import():
	pass

func _on_import_item():
	do_log("importing " + api_item["name"])

func _after_import():
	pass

func _create_item():
	pass

func _import_item():
	pass
