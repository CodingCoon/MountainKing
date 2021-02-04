class_name Job

const Dwarf = preload("res://src/actor/Dwarf.gd")

var tasks : Array
var currentTask : Task

func _init(owner: Dwarf):
	tasks = initTasks(owner)

func initTasks(owner: Dwarf) -> Array:
	assert (false, "ERROR") # has to get overriden
	return [] 

func repeat(owner: Dwarf):
	tasks = initTasks(owner)

func tasksDone(owner: Dwarf):
	pass # override as you wish 

func process(owner: Dwarf, delta: float):
	setupTask(owner)
	currentTask.process(delta)
	owner.update()

func physicsProcess(owner: Dwarf, delta: float):
	setupTask(owner)
	
	currentTask.physicsProcess(delta)
	owner.update()
	if currentTask.isFinished():
		currentTask = null
		if tasks.empty():
			tasksDone(owner);

func setupTask(owner: Dwarf):
	if !currentTask:
		currentTask = tasks.pop_front()
#		print("Pop task: " + currentTask.get_class() + " of " + get_class() )
		assert(currentTask, "popped task is null")
		var started = currentTask.start()
		if started && ! started.empty():
			print(str(currentTask) + " fails with " + started)
			abort(owner)

func abort(owner: Dwarf):
	print("Dwarf " + str(owner.dwarfId) + " aborts its job and gets unemployed.")
	owner.assignJob(load("res://src/job/UnemployedJob.gd").new(owner))

#func physicsProcess(owner: Dwarf, delta: float):
#	if currentTask:
#		print("Job and Task " + str(currentTask))
#		currentTask.physicsProcess(delta)
#		owner.update()

func draw():
	if (currentTask):		# possible, that initially its nil
		currentTask.display()
