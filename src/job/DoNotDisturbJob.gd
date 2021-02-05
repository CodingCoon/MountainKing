class_name DoNotDisturbJob extends Job

#---------------------------------------------------- Preload
#---------------------------------------------------- Parameters
#---------------------------------------------------- Initialize
func _init().("DoNotDisturbJob"):
	pass

#---------------------------------------------------- Methods
func createTask(owner: Dwarf) -> Task:
	var generator = RandomNumberGenerator.new()
	generator.randomize()
	
	var newLocation = Vector2(generator.randi_range(0, 1000), generator.randi_range(0, 600))			# todo Map coords
	var goSomewhereElse = load("res://src/task/GoToPointTask.gd").new(owner, newLocation)
	return goSomewhereElse;

#---------------------------------------------------- Inner CLasses
#---------------------------------------------------- End
