class_name KeyController extends Node2D

var showMountain = true

func _input(event):
	if Input.is_key_pressed(KEY_Q):  # auf observer umstellen
		showMountain = ! showMountain
		$MountainOverlay.visible = showMountain
		$MountainOverlay2.visible = showMountain
	elif Input.is_key_pressed(KEY_D):  # auf observer umstellen
		get_node("Navigation2D/YSort/Signpost").spawnDwarf()
		
		
