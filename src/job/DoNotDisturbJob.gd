class_name DoNotDisturbJob extends Job

func get_class():
	return "DoNotDisturbJob"

func _init(owner: Dwarf).(owner):
	pass

func initTasks(owner: Dwarf) -> Array:
	var generator = RandomNumberGenerator.new()
	generator.randomize()
	var newLocation = Vector2(generator.randi_range(0, 1000), generator.randi_range(0, 600))
	var goSomewhereElse = load("res://src/task/GoToPointTask.gd").new(owner, newLocation)
	return [goSomewhereElse]

func tasksDone(owner: Dwarf):
	var newJob = load("res://src/job/UnemployedJob.gd")
	owner.assignJob(newJob.new(owner))
