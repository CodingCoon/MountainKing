class_name WorkingArea extends Node2D

signal areaEntered(workingArea)

export var direction : String
var worker

#func onAreaEntered(body):
#	var dwarf := body as Dwarf
#	if dwarf:
#		dwarf.onWorkingAreaEntered(self)
