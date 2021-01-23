class_name UnemployedJob extends Job

var overseer

func get_class():
	return "Unemployed"

func _init(owner: Dwarf).(owner):
	pass

func initTasks(owner: Dwarf) -> Array:
	overseer = owner.get_node("../Overseer")
	var go = GoToTargetTask.new(owner, overseer)
	var ask = load("res://src/task/GetAJobTask.gd").new(owner, overseer)
	var wait = WaitTask.new(owner)
	return [go, ask, wait]
