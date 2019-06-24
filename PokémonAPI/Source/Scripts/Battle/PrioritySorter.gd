extends Object

class Sorter:
	static func sort(a, b):
		if a.priority == b.priority:
			if a.TEST_speed > b.TEST_speed:
				return true
			else:
				return false
		elif a.priority > b.priority:
			return true
		else:
			return false

static func sort(list):
	list.sort_custom(Sorter, "sort")
	var same_prio_list = []
	var same_prio: bool
	for i in list.size():
		same_prio = true
		if i == 0:
			same_prio_list.append(list[0])
		else:
			var item1 = list[i - 1]
			var item2 = list[i]
			same_prio = item1.priority == item2.priority && item1.TEST_speed == item2.TEST_speed
			if same_prio:
				same_prio_list.append(list[i])
		if not same_prio || i == list.size() - 1:
			if same_prio_list.size() > 1:
				same_prio_list.shuffle()
				for k in same_prio_list.size():
					list[i - (same_prio_list.size() - 1) + k] = same_prio_list[k]
			same_prio_list.clear()
			same_prio_list.append(list[i])