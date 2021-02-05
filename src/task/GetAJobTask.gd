class_name GetAJobTask extends Task
#---------------------------------------------------- Preload
#---------------------------------------------------- Parameters
var overseer

#---------------------------------------------------- Initialize
func _init(owner: Dwarf, overseer).(owner, "GetAJobTask/" + str(get_instance_id())):
	self.overseer = overseer

#---------------------------------------------------- Public Methods
func process(delta: float):
	owner.updateAnimation("")	# TODO check for a common on start update animation
	overseer.askForAJob(owner)
	finish()

#---------------------------------------------------- Abstract Methods
#---------------------------------------------------- Private Methods
#---------------------------------------------------- Inner Classes
#---------------------------------------------------- End


