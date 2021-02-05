class_name Dwarf extends KinematicBody2D

var job # never be null
var dwarfId: String 
var dwarfName: String 
var leverage : int = 1 

var carryLimit = 3
var carriedObjects : Array

func _init():
	dwarfId = "#" + str(Global.getAndIncDwarfCount())
	dwarfName = load("res://src/actor/NameService.gd").new().getName()

func _ready():
#	print(str(self) + " ready")
	job = load("res://src/job/UnemployedJob.gd").new()

func _process(delta):
	job.process(self, delta)

func _physics_process(delta):
	job.physicsProcess(self, delta)

func _draw():
	job.draw()

func carry(resourceType):
	carriedObjects.append(resourceType)

func stockInto(warehouse):
	while carriedObjects.size() > 0:
		var resource = carriedObjects.pop_front()
		warehouse.store(resource, 1)

func hasCarryLimit():
	return carryLimit == carriedObjects.size()

func assignJob(job):
	if (dwarfId == "#8") :
		print("#8 " + job.get_class())	
	
	assert (job)
#	print("gets job: " + job.get_class())
	self.job = job 

func abortTask():
	job.currentTask.finish()

func updateAnimation(animation: String):
	if animation.empty():
		$Sprite.stop()
	else:
		$Sprite.play(animation)
