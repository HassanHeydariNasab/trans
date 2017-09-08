extends Node

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()
const lingvoj = ["eo", "en"]

func _ready():
	Agordejo.load(agordejo)
	if Agordejo.get_value("Lingvo", "lingvo") == null:
		Tutmonda.lingvo_elektita = false
		get_tree().change_scene("res://Lingvo.tscn")
	else:
		Tutmonda.lingvo_elektita = true
		get_tree().change_scene("res://Niveloj.tscn")