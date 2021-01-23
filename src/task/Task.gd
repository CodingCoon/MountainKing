class_name Task

const Dwarf = preload("res://src/actor/Dwarf.gd")

var owner: Dwarf
var finished : bool = false

func _init(owner: Dwarf):
	assert(owner, "ERROR: every task needs an owner.")
	self.owner = owner

func getOwner() -> Dwarf:
	return owner

func start():
	pass

func process(delta):
	pass

func physicsProcess(delta):
	pass	

func display():
	pass

func finish():
	owner = null;
	finished = true;
	
func isFinished():
	return finished
