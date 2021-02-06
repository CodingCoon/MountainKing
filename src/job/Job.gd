class_name Job

#_______________________________________________ Import
const Dwarf = preload("res://src/actor/Dwarf.gd")

#_______________________________________________ Parameters
var currentTask : Task
var finished = false
var name

#_______________________________________________ Initialize
func _init(name):
	self.name = name

#_______________________________________________ Methods
func get_class():
	return name

func process(owner: Dwarf, delta: float):
	assert(! finished, "don't process a finished job: " + get_class())
	owner.update()
	
	# if no 
	if ! currentTask:
		currentTask = createTask(owner)
		
		if ! currentTask:
			finish(owner)
			return
		else :
			var error = currentTask.start()
			if error != null && ! error.empty():
				abort(owner, error)
				return
	
	# process the task
	currentTask.process(delta);
	
	# check if task finished
	if currentTask.isFinished():
		taskFinished(owner)
		currentTask = null


func physicsProcess(owner: Dwarf, delta: float):
	assert(! finished, "don't process a finished job: " + get_class())
	owner.update()
	
	if ! currentTask:
		currentTask = createTask(owner)
		
		if ! currentTask:
			finish(owner)
			return
		else :
			var error = currentTask.start()
			if error != null && ! error.empty():
				abort(owner, error)
				return
	
	# process the task on the physics layer
	currentTask.physicsProcess(delta);
	
	# check if task finished
	if currentTask.isFinished():
		taskFinished(owner)
		currentTask = null

func abort(owner: Dwarf, error):
	print("Dwarf " + str(owner.dwarfId) + " aborts its job and gets unemployed.")
	print("Reason: " + str(error))
	finished = true
	owner.assignJob(load("res://src/job/UnemployedJob.gd").new())

func finish(owner: Dwarf):
	finished = true;
	var newJob = load("res://src/job/UnemployedJob.gd")
	owner.assignJob(newJob.new())

func draw():
	if (currentTask):		# possible, that initially its nil
		currentTask.display()

#_______________________________________________ Abstract Methods
func createTask(owner: Dwarf) -> Task:
	assert(true, "overwrite createTask: " + get_class())
	return null
	
func taskFinished(owner: Dwarf):
	assert(true, "overwrite taskFinished: " + get_class())
	pass

#_______________________________________________ Inner CLasses
#_______________________________________________ End
