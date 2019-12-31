extends Node

const PrioritySorter = preload("res://Source/Scripts/Battle/PrioritySorter.gd")
const RegisteredSubject = preload("res://Source/Scripts/Battle/RegisteredSubject.gd")

var registered_subjects: Dictionary = {}

func register(subject, message: String, method: String, priority: int = 1):
	var registered_subject = RegisteredSubject.new()
	registered_subject.priority = priority
	registered_subject.subject = subject
	registered_subject.method = method
	if registered_subjects.has(message):
		registered_subjects[message].append(registered_subject)
	else:
		registered_subjects[message] = [registered_subject]

func unregister(subject, message: String):
	if registered_subjects.has(message):
		var subjects = registered_subjects[message]
		for s in subjects:
			if s.subject == subject:
				subjects.erase(s)
				break

func notify(message: String):
	if registered_subjects.has(message):
		var subjects = registered_subjects[message]
		PrioritySorter.sort(subjects)
		for s in subjects:
			s.notify()