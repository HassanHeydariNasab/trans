extends Control

func _ready():
	get_tree().set_auto_accept_quit(false)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().change_scene("res://Niveloj.tscn")

func _on_Bone_pressed():
	get_tree().change_scene("res://Niveloj.tscn")
	
func _on_Kodo_pressed():
	OS.shell_open("https://github.com/HassanHeydariNasab/trans")
