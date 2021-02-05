class_name ReserveResourceTask extends Task

#---------------------------------------------------- Preload
#---------------------------------------------------- Parameters
var targetTree	# input
var workingArea # output

#---------------------------------------------------- Initialize
func _init(owner: Dwarf, targetTree: TreeRes).(owner):
	self.targetTree = targetTree
	
#---------------------------------------------------- Methods
func process(delta):
	workingArea = targetTree.reserve(owner)
	finish();

#---------------------------------------------------- Inner Classes
#---------------------------------------------------- End
