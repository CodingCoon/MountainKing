class_name LumberjackJob extends Job

var state : JobState = JobState.new(); 

func get_class():
	return "Lumberjack Job"

func _init(owner: Dwarf).(owner):
	pass

func initTasks(owner: Dwarf) -> Array:
	var findTree = state.getTask(owner) 
	return [findTree]

func tasksDone(owner: Dwarf):
	if state.ends():
		state.clear();
		.repeat(owner)
	else:
		currentTask 
