extends WATTest

const TEST_SUBJECT_PATH = "res://Tests/TestSubject.gd"

const Observable = preload("res://Tests/TestObservable.gd")
const TestSubject = preload(TEST_SUBJECT_PATH)

const MESSAGE_A = "MESSAGE_A"
const MESSAGE_B = "MESSAGE_B"
const MESSAGE_C = "MESSAGE_C"

var observable: Observable
var test_subject_1: TestSubject
var test_subject_2: TestSubject

func pre():
	observable = Observable.new()
	add_child(observable)
	observable.owner = self
	
	test_subject_1 = TestSubject.new()
	add_child(test_subject_1)
	test_subject_1.owner = self
	test_subject_1.observable = observable
	test_subject_1.subject_name = "subject1"
	
	test_subject_2 = TestSubject.new()
	add_child(test_subject_2)
	test_subject_2.owner = self
	test_subject_2.observable = observable
	test_subject_2.subject_name = "subject2"

func end():
	remove_child(test_subject_1)
	remove_child(test_subject_2)
	remove_child(observable)

func test_normal_call():
	expect.is_equal(0, test_subject_1.call_count_1, "Method1 called 0 times")
	expect.is_equal(0, test_subject_1.call_count_2, "Method2 called 0 times")
	test_subject_1.test_method_1()
	expect.is_equal(1, test_subject_1.call_count_1, "Method1 called 1 times")
	expect.is_equal(0, test_subject_1.call_count_2, "Method2 called 0 times")
	test_subject_1.test_method_1()
	test_subject_1.test_method_2()
	expect.is_equal(2, test_subject_1.call_count_1, "Method1 called 2 times")
	expect.is_equal(1, test_subject_1.call_count_2, "Method1 called 1 times")

func test_notification():
	observable.notify(MESSAGE_A)
	expect.is_equal(0, test_subject_1.call_count_1, "Method1 called 0 times on subject 1")
	expect.is_equal(0, test_subject_2.call_count_1, "Method1 called 0 times on subject 2")
	expect.is_equal(0, test_subject_1.call_count_2, "Method2 called 0 times on subject 1")
	expect.is_equal(0, test_subject_2.call_count_2, "Method2 called 0 times on subject 2")
	
	test_subject_1.register(observable, MESSAGE_A, "test_method_1")
	observable.notify(MESSAGE_A)
	expect.is_equal(1, test_subject_1.call_count_1, "Method1 called 1 times on subject 1")
	expect.is_equal(0, test_subject_2.call_count_1, "Method1 called 0 times on subject 2")
	expect.is_equal(0, test_subject_1.call_count_2, "Method2 called 0 times on subject 1")
	expect.is_equal(0, test_subject_2.call_count_2, "Method2 called 0 times on subject 2")
	
	test_subject_2.register(observable, MESSAGE_B, "test_method_2")
	observable.notify(MESSAGE_B)
	expect.is_equal(1, test_subject_1.call_count_1, "Method1 called 1 times on subject 1")
	expect.is_equal(0, test_subject_2.call_count_1, "Method1 called 0 times on subject 2")
	expect.is_equal(0, test_subject_1.call_count_2, "Method2 called 0 times on subject 1")
	expect.is_equal(1, test_subject_2.call_count_2, "Method2 called 1 times on subject 2")
	
	test_subject_1.unregister(observable, MESSAGE_A)
	test_subject_2.register(observable, MESSAGE_A, "test_method_1")
	observable.notify(MESSAGE_A)
	expect.is_equal(1, test_subject_1.call_count_1, "Method1 called 1 times on subject 1")
	expect.is_equal(1, test_subject_2.call_count_1, "Method1 called 1 times on subject 2")
	expect.is_equal(0, test_subject_1.call_count_2, "Method2 called 0 times on subject 1")
	expect.is_equal(1, test_subject_2.call_count_2, "Method2 called 1 times on subject 2")
	
	test_subject_2.unregister_all()
	observable.notify(MESSAGE_A)
	expect.is_equal(1, test_subject_2.call_count_1, "Method1 called 1 times on subject 2")
	expect.is_equal(1, test_subject_2.call_count_2, "Method2 called 1 times on subject 2")
	
	observable.notify(MESSAGE_B)
	expect.is_equal(1, test_subject_2.call_count_1, "Method1 called 1 times on subject 2")
	expect.is_equal(1, test_subject_2.call_count_2, "Method2 called 1 times on subject 2")

func test_priority():
	test_subject_1.register(observable, MESSAGE_C, "test_method_1", 3)
	test_subject_2.register(observable, MESSAGE_C, "test_method_2", 5)
	observable.notify(MESSAGE_C)
	expect.is_equal("Called Method1 on subject1", observable.text, "Last called Method1 on subject 1")
	
	test_subject_1.register(observable, MESSAGE_B, "test_method_1", 12)
	test_subject_2.register(observable, MESSAGE_B, "test_method_2", -3)
	observable.notify(MESSAGE_B)
	expect.is_equal("Called Method2 on subject2", observable.text, "Last called Method2 on subject 2")
	