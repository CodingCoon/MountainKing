class_name GetAJobTask extends Task

var overseer

func get_class(): return "GetAJobTask/" + str(get_instance_id())

func _init(owner: Dwarf, overseer).(owner):
	self.overseer = overseer

func process(delta: float):
	owner.updateAnimation("")
	overseer.askForAJob(owner)
	.finish()
	# todo brauch ich dann überhaupt einen Wait, wenn ich einfach hier nie finishe
		# ggf. nutz ich das für statistik wer alles wartet
	
