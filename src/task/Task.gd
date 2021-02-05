class_name Task

#---------------------------------------------------- Preload
const Dwarf = preload("res://src/actor/Dwarf.gd")

#---------------------------------------------------- Parameters
var owner: Dwarf
var name
var finished : bool = false

#---------------------------------------------------- Initialize
func _init(owner: Dwarf, name: String):
	assert(owner, "ERROR: every task needs an owner.")
	self.owner = owner
	self.name = name
	
#---------------------------------------------------- Public Methods
func get_class(): 
	return name

func start() -> String:
	return ""

func finish():
	owner = null;
	finished = true;
	
func isFinished():
	return finished
	
#---------------------------------------------------- Abstract Methods
func process(delta):
	pass

func physicsProcess(delta):
	pass

func display():
	pass

#---------------------------------------------------- Private Methods
#---------------------------------------------------- Inner Classes
#---------------------------------------------------- End
