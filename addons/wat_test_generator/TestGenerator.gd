extends Control

var files: Array
const IGNORED_METHODS = ["_init", "_ready", "_enter_tree"]

func _ready():
	pass

func _on_ButtonPath_button_down():
	$DirectoryDialog.visible = true
	$DirectoryDialog.invalidate()

func _on_DirectoryDialog_dir_selected(dir):
	files.append(dir)
	$EditPath.text = dir

func _on_DirectoryDialog_file_selected(path):
	files.append(path)
	$EditPath.text = path

func _on_DirectoryDialog_files_selected(paths):
	$EditPath.text = ""
	for path in paths:
		files.append(path)
		$EditPath.text = $EditPath.text + path + ";"

func to_sneak_case(s: String) -> String:
	var result := ""
	for i in range(s.length()):
		var letter = s.substr(i, 1)
		var lower_letter = letter.to_lower()
		if i > 0 && letter != lower_letter:
			result += "_"
		result += lower_letter
	return result

func generate_test(file: String) -> void:
	var test_file = File.new()
	var test_file_name = file.replace("res://Source", "res://Tests")
	var name_of_class := file.substr(file.find_last("/") + 1).trim_suffix(".gd")
	var dir_path = test_file_name.trim_suffix(name_of_class + ".gd")
	test_file_name = dir_path + name_of_class + "Tests.gd"
	if test_file.file_exists(test_file_name):
		return
	var source_file = File.new()
	if source_file.open(file, File.READ) != OK:
		return
	var script_content = source_file.get_as_text()
	source_file.close()
	var script = GDScript.new()
	script.source_code = script_content
	script.reload()
	var instance_name = to_sneak_case(name_of_class)
	var test_script = "extends WATTest\n\n"
	test_script += "const " + name_of_class + " = preload(\"" + file + "\")\n"
	test_script += "var " + instance_name + ": " + name_of_class + "\n\n"
	var methods = script.get_script_method_list()
	var used_methods = {}
	for method in methods:
		var method_name = method["name"]
		if not IGNORED_METHODS.has(method_name) && not used_methods.has(method_name):
			if not method_name.begins_with("_"):
				method_name = "_" + method_name
			test_script += "func test" + method_name + "() -> void:\n\tpass\n\n"
			used_methods[method_name] = true
	test_script += "func pre() -> void:\n\t" + instance_name + " = " + name_of_class + ".new()\n"
	var directory = Directory.new()
	if not directory.dir_exists(dir_path):
		directory.make_dir_recursive(dir_path)
	var result = test_file.open(test_file_name, File.WRITE)
	if result == OK:
		test_file.store_string(test_script)
		test_file.close()

func _on_ButtonGenerate_button_down():
	var dir = Directory.new()
	for file in files:
		var subfiles = []
		get_all_files(subfiles, file)
		for subfile in subfiles:
			generate_test(subfile)

func get_all_files(array: Array, sub_dir: String) -> void:
	var directory = Directory.new()
	if directory.open(sub_dir) == OK:
		directory.list_dir_begin(true, true)
		var filename = directory.get_next()
		while filename != "":
			if directory.current_is_dir():
				get_all_files(array, sub_dir + "/" + filename)
			elif filename.ends_with(".gd"):
				array.append(sub_dir + "/" + filename)
			filename = directory.get_next()
	elif sub_dir.ends_with(".gd"):
		array.append(sub_dir)
