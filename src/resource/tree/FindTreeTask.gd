class_name FindTreeTask extends Task

#---------------------------------------------------- Preload
#---------------------------------------------------- Parameters
var foundTree

#---------------------------------------------------- Initialize
func _init(owner: Dwarf).(owner, "FindTreeTask"):
	pass 
	
#---------------------------------------------------- Methods
func process(delta):
	var dwarfPosition = owner.position
	var shortestDistance = -1
	var closestTree
	
	for tree in owner.get_tree().get_nodes_in_group("tree"):
		var distance = tree.position.distance_to(dwarfPosition)
		
		if (shortestDistance == -1 || distance < shortestDistance):
			if tree.hasFreeWorkingArea():
				shortestDistance = distance
				foundTree = tree
	
	finish();

#---------------------------------------------------- Inner Classes
#---------------------------------------------------- End
