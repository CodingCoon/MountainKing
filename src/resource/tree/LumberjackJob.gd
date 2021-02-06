class_name LumberjackJob extends Job

#---------------------------------------------------- Preload
#---------------------------------------------------- Parameters
const TREE_SEARCH_DURATION = 10

var state = State.FIND_TREE

var targetTree : TreeRes
var workingArea
var warehouse

var noTreeFoundCount : int = 0

#---------------------------------------------------- Initialize
func _init().("LumberjackJob"):
	pass
	
#---------------------------------------------------- Methods
func createTask(owner: Dwarf) -> Task:
	match state:
		State.FIND_TREE:
			return load("res://src/resource/tree/FindTreeTask.gd").new(owner)
		State.RESERVE_TREE:
			return load("res://src/resource/tree/ReserveTreeTask.gd").new(owner, targetTree)
		State.GO_TO_TREE:
			return load("res://src/task/GoToPointTask.gd").new(owner, workingArea.get_global_position(), "axe")
		State.CHOP_TREE:
			return load("res://src/resource/tree/ChopWoodTask.gd").new(owner, targetTree)
		State.GO_TO_WAREHOUSE: 
			return load("res://src/task/GoToPointTask.gd").new(owner, warehouse.getTarget())
		State.STOCK_GOODS:
			return load("res://src/resource/StockResourceTask.gd").new(owner, warehouse)
	return .createTask(owner)
	
func taskFinished(owner: Dwarf):
	match state:
		State.FIND_TREE:
			afterFindTree()
		State.RESERVE_TREE:
			afterReserveTree()
		State.GO_TO_TREE:
			state = State.CHOP_TREE
		State.CHOP_TREE:
			state = State.GO_TO_WAREHOUSE
			warehouse = owner.get_node("../Warehouse")
		State.GO_TO_WAREHOUSE: 
			state = State.STOCK_GOODS
		State.STOCK_GOODS:
			state = State.FIND_TREE		#TODO maybe check if the dwarf should work further as a lumberjack


func afterFindTree():
	targetTree = currentTask.foundTree
	if targetTree:
		state = State.RESERVE_TREE
	else: 
		noTreeFoundCount += 1
		if noTreeFoundCount > TREE_SEARCH_DURATION:
			# todo -> 
			pass

func afterReserveTree():
	workingArea = currentTask.workingArea
	if workingArea:
		noTreeFoundCount = 0
		state = State.GO_TO_TREE
	else :
		state = State.FIND_TREE

#---------------------------------------------------- Inner Classes
enum State {
	FIND_TREE,
	RESERVE_TREE,
	GO_TO_TREE,
	CHOP_TREE,
	GO_TO_WAREHOUSE,
	STOCK_GOODS
}

#---------------------------------------------------- End
