class_name ChopWoodTask extends Task

var tree : TreeRes
var progress : float = 0

func _init(owner: Dwarf, tree: TreeRes).(owner, "ChopWoodTask"):
	self.tree = tree

func start():
	var side = tree.getSide(owner)
	owner.updateAnimation(side + "_chop")		# side from treeRes

func process(delta:float): 
	progress += delta
	if progress >= tree.WORKLOAD:
		owner.carry(tree.resourceType)
		progress -= tree.WORKLOAD
		tree.decrementValue()
		
		if (tree.value == 0 || 
			owner.hasCarryLimit()):
				tree.cancel(owner)
				finish()
