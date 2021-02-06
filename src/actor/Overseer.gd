class_name Overseer extends KinematicBody2D

export var ASSIGNMENT_DURATION : float = 3.0

var unemployeed : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta: float):
	updateUnmeployeed(delta)
	
func getTarget() :
	return $Target.get_global_position()
	
func askForAJob(requester: Dwarf):
	if not unemployeed.has(requester):
		unemployeed[requester] = 0

func updateUnmeployeed(delta: float):
	for unemployee in unemployeed:
		unemployeed[unemployee] += delta
		
		if unemployeed[unemployee] >= ASSIGNMENT_DURATION:
			#var newJob = load("res://src/job/DoNotDisturbJob.gd")
			var newJob = load("res://src/resource/tree/LumberjackJob.gd")
			unemployee.assignJob(newJob.new())
			unemployeed.erase(unemployee)
