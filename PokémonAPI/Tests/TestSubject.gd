extends "res://Source/Scripts/Common/Subject.gd"

var call_count_1
var call_count_2
var observable
var subject_name: String

func test_method_1():
	call_count_1 += 1
	observable.text = "Called Method1 on " + subject_name

func test_method_2():
	call_count_2 += 1
	observable.text = "Called Method2 on " + subject_name

func _init():
	call_count_1 = 0
	call_count_2 = 0