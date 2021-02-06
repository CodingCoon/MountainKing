class_name TreeRes extends CanvasItem

enum Direction {
	RIGHT_BOTTOM
	RIGHT,
	RIGHT_TOP,
	LEFT_TOP,
	LEFT,
	LEFT_BOTTOM
}

const ResourceType = preload("res://src/resource/ResourceType.gd")
const SIZING = [0, 5, 15, 30, 50, 70, 85, 95, 100]

const GROW_RATE : float = 5.0
export var size : int = 1
var growing : bool = true
var growingProcess : float = 0.0

const DROP_RATE : int = 10
var dropProcess : float = 0.0

const UNWORKED_TIME_TO_REGROW : int = 10
var unworkedProcess : float = 0.0

const WORKLOAD : float = 10.0 # delta to earn one value
var resourceType = ResourceType.Type.TIMBER	# todo to const
var value : int = size

func _init():
	add_to_group("tree")

func _ready():
	updateUI()
	value = size

func decrementValue():
	value -= 1
	growing = false
	#print("Baum mit value : " + str(value))
	if value == 0:
		print("Baum tot")
		getShownNode().cancelAll()
		get_parent().remove_child(self)

func updateUI():
	var oldshownNode = getShownNode()
	var spriteNo = 0;
	for i in SIZING:
		if size >= i:
			spriteNo += 1
		else :
			break
	
	$T1.set_visible(spriteNo == 1)
	$T2.set_visible(spriteNo == 2)
	$T3.set_visible(spriteNo == 3)
	$T4.set_visible(spriteNo == 4)
	$T5.set_visible(spriteNo == 5)
	$T6.set_visible(spriteNo == 6)
	$T7.set_visible(spriteNo == 7)
	$T8.set_visible(spriteNo == 8)
	$T9.set_visible(spriteNo == 9)
	
	var newShownNode = getShownNode()
	if oldshownNode != newShownNode:
		oldshownNode.copyReservations(newShownNode)

func _process(delta):
#	if name != "Tree":
#		return
	
	if size == 100:
		dropProcess += delta
		dropTree()
	else:
		if growing:
			if size > 80:
				dropProcess += (delta / 2)
				growingProcess += (delta / 2)
				dropTree()
				growTree()
			else:
				growingProcess += delta
				growTree()
		else:
			unworkedProcess += delta		# todo hier einbauen, dass einfach dass der value sich regeniert und wenn der wieder auf size ist, dann go
			#checkRegrow()

func getShownNode():
	if $T1.visible: return $T1
	elif $T2.visible: return $T2
	elif $T3.visible: return $T3
	elif $T4.visible: return $T4
	elif $T5.visible: return $T5
	elif $T6.visible: return $T6
	elif $T7.visible: return $T7
	elif $T8.visible: return $T8
	elif $T9.visible: return $T9
	else:
		print("ERROR: no visible Sprite")
		return null;
	
func getGlobalPosition() -> Vector2:
	return getShownNode().get_global_position()

func checkRegrow():
	if unworkedProcess >= UNWORKED_TIME_TO_REGROW:
		growing = true
		unworkedProcess = 0
	
func growTree():
	if growingProcess >= GROW_RATE:
		size += 1
		value = size
		var v = Vector2(1.0 + (size/100.0), 1.0 + (size/100.0))
		growingProcess -= GROW_RATE
#		set_scale(v)
		updateUI()

#	 COS		 SIN
#	 0,8660		-0,5000	
#	 0,0000		-1,0000
#	-0,8660		-0,5000
#	-0,8660	 	 0,5000
#	 0,0000		 1,0000
#	 0,8660		 0,5000
func dropTree():
	if dropProcess >= DROP_RATE:
		dropProcess = 0
		
		var directionsWithoutTrees : Array = Direction.values()
		for tree in get_tree().get_nodes_in_group("tree"):
			
			if tree == self:
				continue
			var distance = tree.getGlobalPosition().distance_to(getGlobalPosition());
#			print("--" + tree.name)
#			print("  |--" + str(tree.getGlobalPosition()) + " -> " + str(getGlobalPosition()))
#			print("  |--" + str(distance))
			
			if distance < 100: 
				var vector : Vector2 = vector(getGlobalPosition(), tree.getGlobalPosition()).normalized()
				var x = vector.x
				var y = vector.y

				# RIGHT_BOTTOM				
				if (directionsWithoutTrees.has(Direction.RIGHT_BOTTOM) && 
					0.0 <= x && x <= 0.866 &&
					0.5 <= y && y <= 1.0):
					directionsWithoutTrees.erase(Direction.RIGHT_BOTTOM)

				# RIGHT
				elif (directionsWithoutTrees.has(Direction.RIGHT) && 
					0.866 <= x && 
					-0.5 <= y && y <= 0.5) :
					directionsWithoutTrees.erase(Direction.RIGHT)

				# RIGHT_TOP
				elif (directionsWithoutTrees.has(Direction.RIGHT_TOP) && 
					0.0 <= x && x <= 0.866 && 
					-1.0 <= y && y <= -0.5):
					directionsWithoutTrees.erase(Direction.RIGHT_TOP)

				# LEFT_TOP
				elif (directionsWithoutTrees.has(Direction.LEFT_TOP) && 
					-0.866 <= x && x <= 0.0 && 
					-1.0 <= y && y <= -0.5):
					directionsWithoutTrees.erase(Direction.LEFT_TOP)

				# LEFT
				elif (directionsWithoutTrees.has(Direction.LEFT) && 
					-0.866 >= x && 
					-0.5 <= y && y <= 0.5) :
					directionsWithoutTrees.erase(Direction.LEFT)

				# LEFT_BOTTOM				
				if (directionsWithoutTrees.has(Direction.LEFT_BOTTOM) && 
					-0.866 <= x && x <= 0.0 &&
					0.5 <= y && y <= 1.0):
					directionsWithoutTrees.erase(Direction.LEFT_BOTTOM)

		if directionsWithoutTrees.size() > 0:
			dropRandomTree(directionsWithoutTrees)


func dropRandomTree(directionsWithoutTrees: Array):
	var generator = RandomNumberGenerator.new()
	generator.randomize()
	var x
	var y
	var distance = generator.randf_range(25, 100)
	var index = generator.randi_range(0, directionsWithoutTrees.size() - 1)
	var direction = directionsWithoutTrees[index]
#	print("Spawn at " + str(direction))	
	
	match direction:
		Direction.RIGHT_BOTTOM:
#			print("  Drop Tree at RIGHT_BOTTOM")
			x = generator.randf_range(0, 0.8660)
			y = generator.randf_range(1, 0.5)
		Direction.RIGHT:
#			print("  Drop Tree at RIGHT")
			x = generator.randf_range(0.8660, 1)
			y = generator.randf_range(-0.5, 0.5)
		Direction.RIGHT_TOP:
#			print("  Drop Tree at RIGHT_TOP")
			x = generator.randf_range(0, 0.8660)
			y = generator.randf_range(-0.5, -1)
		Direction.LEFT_TOP:
#			print("  Drop Tree at LEFT_TOP")
			x = generator.randf_range(0, -0.8660)
			y = generator.randf_range(-0.5, -1)
		Direction.LEFT:
#			print("  Drop Tree at LEFT")
			x = generator.randf_range(-0.8660, -1)
			y = generator.randf_range(-0.5, 0.5)
		Direction.LEFT_BOTTOM:
#			print("  Drop Tree at LEFT_BOTTOM")
			x = generator.randf_range(0, -0.8660)
			y = generator.randf_range(1, 0.5)

	var treePos = Vector2(x * distance, y * distance)
#	print("  x: " + str(x)  + "  y: " + str(y) + " dis: " + str(distance))
	dropNewTree(treePos)

func dropNewTree(treePos):
	var treeScene = load("res://src/resource/tree/TreeRes.tscn")
	var node = treeScene.instance()
	get_parent().add_child(node)
	node.position = getGlobalPosition() + treePos
	node.name = "ABC"

func vector(source, target) -> Vector2:
	return Vector2(target.x - source.x, target.y - source.y)

func getSide(worker: Dwarf) -> String:
	return getShownNode().getSide(worker)

func hasFreeWorkingArea() -> bool:
	return getShownNode().hasFreeWorkingArea()

func reserve(worker: Dwarf):
	#print(str(self) + "  reserve " + str(worker))
	return getShownNode().reserve(worker)

func cancel(worker: Dwarf):
	#print(str(self) + "  cancel " + str(worker))
	return getShownNode().cancel(worker)
	
#func _draw():
#	if name != "Tree": return
##	draw_circle(Vector2.ZERO, 100.0, Color.black)
#	draw_arc(Vector2.ZERO, 100.0, 75.0, 250.0, 1000, Color.black)
#	draw_line(Vector2(-86.6, -50), Vector2(86.6, 50), Color.black)
#	draw_line(Vector2(-86.6, 50), Vector2(86.6, -50), Color.black)
#	draw_line(Vector2(0, -100), Vector2(0, 100), Color.black)
	
	
	#	 COS		 SIN
#	 0,8660		-0,5000	
#	 0,0000		-1,0000
#	-0,8660		-0,5000
#	-0,8660	 	 0,5000
#	 0,0000		 1,0000
#	 0,8660		 0,5000
	
#	draw_circle(Vector2(100, 100), 200.0, 0.0, 180.0, 1, Color.black)
	
