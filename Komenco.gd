extends Node

func _ready():
	if Tutmonda.Agordejo.get_value("Lingvo", "lingvo") == null:
		Tutmonda.lingvo_elektita = false
		get_tree().change_scene("res://Lingvo.tscn")
	else:
		Tutmonda.lingvo_elektita = true
		get_tree().change_scene("res://Niveloj.tscn")