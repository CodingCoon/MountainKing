class_name UnemployedJob extends Job

#---------------------------------------------------- Preload
var overseer = State.GO_TO_OVERSEER;
var state
#---------------------------------------------------- Parameters
#---------------------------------------------------- Initialize
func _init().("UnemployedJob"):
	pass

#---------------------------------------------------- Methods
func createTask(owner: Dwarf) -> Task:
	if overseer:
		overseer = owner.get_node("../Overseer")
	
	match(state):
		State.GO_TO_OVERSEER:
			return GoToPointTask.new(owner, overseer.getTarget())
		State.ASK_FOR_A_JOB:
			load("res://src/task/GetAJobTask.gd").new(owner, overseer)
		State.WAIT:
			WaitTask.new(owner)
	return .createTask(owner)

func taskFinished(owner: Dwarf):
	match(state):
		State.GO_TO_OVERSEER:
			state = State.ASK_FOR_A_JOB
		State.ASK_FOR_A_JOB:
			state = State.WAIT
		State.WAIT:
			state = null

#---------------------------------------------------- Inner CLasses
enum State {
	GO_TO_OVERSEER,
	ASK_FOR_A_JOB,
	WAIT
}
#---------------------------------------------------- End
