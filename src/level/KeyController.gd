class_name KeyController extends Node2D

var showMountain = true
var block = false; # cause my pc is to fast

func _input(event):
	
	if Input.is_key_pressed(KEY_Q):  # auf observer umstellen
		showMountain = ! showMountain
		$MountainOverlay.visible = showMountain
		$MountainOverlay2.visible = showMountain
	elif Input.is_key_pressed(KEY_D):  # auf observer umstellen
		if block:
			return
		get_node("Navigation2D/YSort/Signpost").spawnDwarf()
		block = true;
	else:
		block = false;
		
		
