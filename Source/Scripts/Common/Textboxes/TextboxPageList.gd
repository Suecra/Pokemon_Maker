extends Object

const TextboxPage = preload("res://Source/Scripts/Common/Textboxes/TextboxPage.gd")

var pages := []
var lines_per_page: int
var font: Font
var textbox_width: float
var is_bbcode: bool

func trim(text: String) -> String:
	while text.begins_with(" "):
		text = text.substr(1, text.length())
	while text.ends_with(" "):
		text = text.substr(0, text.length() - 1)
	return text

func get_raw_text(text: String) -> String:
	if is_bbcode:
		pass
	return trim(text)

func create_pages(text: String, safe_margin = 0) -> void:
	pages.clear()
	
	var lines = text.split("\n", false)
	
	#ignore bbcode for now
	
	var i = 0
	var text_width
	var split_line_1
	var split_line_2
	
	while i < lines.size():
		split_line_2 = ""
		text_width = font.get_string_size(get_raw_text(lines[i]))
		while text_width.x + safe_margin > textbox_width:
			var pos = lines[i].rfind(" ")
			if pos == -1:
				break
			split_line_1 = lines[i].left(pos)
			split_line_2 = lines[i].right(pos) + split_line_2
			lines[i] = split_line_1
			text_width = font.get_string_size(get_raw_text(lines[i]))
		if split_line_2 != "":
			lines[i] = trim(lines[i])
			lines.insert(i + 1, trim(split_line_2))
		i += 1
	
	var pagecount = int(ceil(float(lines.size()) / float(lines_per_page)))
	var page
	var idx
	for j in pagecount:
		page = TextboxPage.new()
		for k in lines_per_page:
			idx = j * lines_per_page + k
			if idx < lines.size():
				page.lines.append(lines[idx])
				page.char_count += lines[idx].length()
		pages.append(page)
