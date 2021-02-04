class_name LumberjackJobContainer extends Node

var state = State.FIND_TREE
var targetTree : TreeRes
var idled : int = 0


func getTask(owner: Dwarf):
	match state:
		FIND_TREE:
			load("res://src/resource/tree/FindTreeTask.gd").new(owner, self, doWhat())
		RESERVE_TREE:
		GO_TO_TREE:
		CHOP_TREE:
		GO_TO_STOCK: 



	var workingArea = findAndReserveTargetTree(owner)
	if ! workingArea:
		# couldn't reserve a working area, so wait for next free tree. TODO, vielleicht kann man das auch smarter machen, so dass man nicht immer arbeitslos wird.
		assert(owner.job != self, "job should have switched to unemployed, but is still this.")
		return []
	
	var workingAreaLocation = workingArea.get_global_position()
	
	var goToTree = load("res://src/task/GoToPointTask.gd").new(owner, workingAreaLocation, "axe") 
	var chopTree = load("res://src/resource/tree/ChopWoodTask.gd").new(owner, targetTree)
	
	# todo hier wäre es schlauer das Skript mitzugeben und erst später die konkrete Instanz zu laden
	# todo selber Baum immer wieder bearbeiten
	# baum soll wachsen einstellen
	var warehouse = owner.get_node("../Warehouse")
	
	var bringToWarehouse = GoToPointTask.new(owner, warehouse.getTarget())
	var stockWood = load("res://src/resource/StockResourceTask.gd").new(owner, warehouse)
	 
	return [goToTree, chopTree, bringToWarehouse, stockWood]


# First take the last tree
# if it is empty look for the closest
# if both are reserved, look again
func findAndReserveTargetTree(owner: Dwarf):
	if targetTree && targetTree.value == 0:
		targetTree = null
	
	while ! targetTree:
		targetTree = findClosestTree(owner)
		if ! targetTree:
			# No trees, so wait
			abort(owner)
			break
			
		assert(targetTree, "Nil targetTree not allowed here: Dwarf@" + str(owner.get_global_position()))	
		var workingArea = targetTree.reserve(owner)
		
		if workingArea:
			return workingArea
		else:
			targetTree = null

func findClosestTree(owner: Dwarf) -> TreeRes:
	var dwarfPosition = owner.position
	var shortestDistance = -1
	var closestTree
#	print("Search")
	
	for tree in owner.get_tree().get_nodes_in_group("tree"):
		var distance = tree.position.distance_to(dwarfPosition)
#		print("Distance: " + str(distance))
		
		if (shortestDistance == -1 || distance < shortestDistance):
			if tree.hasFreeWorkingArea():
				#todo und dieser Place kann angelaufen werden
				shortestDistance = distance
				closestTree = tree
#				print("new closest tree")
	
	return closestTree
	


enum State {
	FIND_TREE,
	RESERVE_TREE,
	GO_TO_TREE,
	CHOP_TREE,
	GO_TO_STOCK
}
