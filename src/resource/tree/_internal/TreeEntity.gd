class_name TreeEntity extends StaticBody2D

var topWorker		# currenty not in use
var bottomWorker
var rightWorker 
var leftWorker

func hasFreeWorkingArea() -> bool:
	return !rightWorker || !leftWorker
#	return !topWorker || !rightWorker || !bottomWorker || !leftWorker

func copyReservations(var newTree : TreeEntity):
	newTree.leftWorker = leftWorker
	leftWorker = null
	newTree.rightWorker = rightWorker
	rightWorker = null
#	newTree.topWorker = topWorker
#	topWorker = null
#	newTree.bottomWorker = bottomWorker
#	bottomWorker = null

func getSide(worker: Dwarf):			# notice that a left worker chops to the right and vice versa
	if leftWorker == worker:
		return "right"
	elif rightWorker == worker:
		return "left"


# Returns a working area if the reservation succeeded 
func reserve(worker: Dwarf):
	if not leftWorker:
		leftWorker = worker
		return $Left
	elif not rightWorker:
		rightWorker = worker
		return $Right
#	elif not topWorker:
#		topWorker = worker
#		return $Top
#	elif not bottomWorker:
#		bottomWorker = worker
#		return $Bottom
	else:
		return null
		#assert(false, "Don't reserve without a free working area. Tree@ " + str(.global_position() + "  Dwarf@" + str(worker.global_position())))

func cancelAll():
	if leftWorker:
		leftWorker.abortTask()
		leftWorker = null
	if rightWorker:
		rightWorker.abortTask()
		rightWorker = null
#	if topWorker:
#		topWorker.abortTask()
#		topWorker = null
#	if bottomWorker:
#		bottomWorker.abortTask()
#		bottomWorker = null

func cancel(worker: Dwarf):
	if leftWorker == worker:
		leftWorker = null
	elif rightWorker == worker:
		rightWorker = null
#	elif topWorker == worker:
#		topWorker = null
#	elif bottomWorker == worker:
#		bottomWorker = null
	else:
		assert(false, "Don't cancel a dwarf that isn't working here.")
