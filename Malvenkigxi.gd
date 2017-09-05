extends Node2D

func _ready():
	pass

func _on_Rekomencu_pressed():
	get_tree().change_scene("res://Bazo.tscn")

func _on_Niveloj_pressed():
	get_tree().change_scene("res://Niveloj.tscn")