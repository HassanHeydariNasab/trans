extends Node2D

func _ready():
	pass

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().change_scene("res://Niveloj.tscn")

func _on_Rekomencu_pressed():
	get_tree().change_scene("res://Bazo.tscn")

func _on_Niveloj_pressed():
	get_tree().change_scene("res://Niveloj.tscn")