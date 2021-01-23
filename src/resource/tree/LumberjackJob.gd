class_name LumberjackJob extends Job

var targetTree : TreeRes

func get_class():
	return "Lumberjack Job"

func _init(owner: Dwarf).(owner):
	pass

func initTasks(owner: Dwarf) -> Array:
	#if (targetTree still sized, than chop further)
	# später soll es dann so sein, dass man einen baum fällt und natürlich 
	# immer den gleichen bearbeitet, bis der erledigt ist
	
	if !targetTree || targetTree.value == 0 :
		targetTree = findClosestTree(owner)
		if !targetTree:
			assert(false, "no trees left.") # todo
	
	var workingArea = targetTree.reserve(owner)
	var workingAreaLocation = workingArea.get_global_position()
	var goToTree = load("res://src/task/GoToPointTask.gd").new(owner, workingAreaLocation, "axe") 
	var chopTree = load("res://src/resource/tree/ChopWoodTask.gd").new(owner, targetTree)
	
	# todo hier wäre es schlauer das Skript mitzugeben und erst später die konkrete Instanz zu laden
	# todo selber Baum immer wieder bearbeiten
	# baum soll wachsen einstellen
	var warehouse = owner.get_node("../Warehouse")
	
	var bringToWarehouse = GoToTargetTask.new(owner, warehouse)
	var stockWood = load("res://src/resource/StockResourceTask.gd").new(owner, warehouse)
	 
	return[goToTree, chopTree, bringToWarehouse, stockWood]

func tasksDone(owner: Dwarf):
	.repeat(owner)

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
