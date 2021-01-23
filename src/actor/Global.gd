extends Node

var dwarfCount : int

func _ready():
	dwarfCount = 0
	
func getAndIncDwarfCount() -> int:
	var value : int = dwarfCount
	dwarfCount += 1
	return value
