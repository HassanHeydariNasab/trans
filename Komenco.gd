extends Node

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()
const lingvoj = ["eo", "en"]

func _ready():
	Agordejo.load(agordejo)
	if Agordejo.get_value("Lingvo", "lingvo") == null:
		get_tree().change_scene("res://Lingvo.tscn")
	else:
		get_tree().change_scene("res://Niveloj.tscn")