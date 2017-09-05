extends Area2D

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()
const lingvoj = ["eo", "en"]

func _ready():
	pass

func _on_Finejo_body_enter( korpo ):
	if korpo.get_name() == "K":
		Agordejo.load(agordejo)
		Agordejo.set_value("Niveloj", str(Tutmonda.nivelo),
			Tutmonda.Tempilo.get_time_left()
		)
		Agordejo.set_value("Niveloj", str(Tutmonda.nivelo+1), 0)
		Agordejo.save(agordejo)
		get_tree().change_scene("res://Niveloj.tscn")
