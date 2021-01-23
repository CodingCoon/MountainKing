class_name Signpost extends Node2D

export var NEW_DWARF_DURATION = 100.0
export var onlyOne = true 

var duration = 0
var spawned = false

var dwarfs = 0

var pProcessing = 0
var ppValues = 0

func _process(delta):
	if spawned:
		return
	
	duration += delta
	if duration >= NEW_DWARF_DURATION:
		spawnDwarf()
		if onlyOne: 
			spawned = true


func _physics_process(delta):
	pProcessing += delta
	ppValues += 1
	
	if ppValues % 100 == 0:
		ppValues = 0
		pProcessing = 0
	
func spawnDwarf():
	#print("New Dwarf")
	var dwarfScene = load("res://src/actor//Dwarf.tscn")
	var newDwarf = dwarfScene.instance();
	newDwarf.set_name("Dwarf")
	#print("Set Position")
	newDwarf.position = position
	
	#print("Add Dwarf " + str(newDwarf))
	get_parent().add_child(newDwarf)
	newDwarf.set_owner(get_parent())
	duration -= NEW_DWARF_DURATION
	dwarfs += 1
	if dwarfs % 10 == 0:
		print(str(dwarfs))
