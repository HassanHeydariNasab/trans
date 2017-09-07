extends Area2D

onready var Bazo = get_tree().get_root().get_node("/root/Bazo")

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()

func _ready():
	pass

func _on_Finejo_body_enter( korpo ):
	if korpo.get_name() == "K":
		Agordejo.load(agordejo)
		if Agordejo.get_value("Niveloj", str(Tutmonda.nivelo), 0) < Bazo.Tempilo.get_time_left():
			Agordejo.set_value("Niveloj", str(Tutmonda.nivelo),
				int(Bazo.Tempilo.get_time_left())
			)
			Agordejo.save(agordejo)
			Tutmonda.rekordita = true
		get_tree().change_scene("res://Niveloj.tscn")
