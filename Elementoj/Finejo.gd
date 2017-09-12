extends Area2D

onready var Bazo = get_tree().get_root().get_node("/root/Bazo")

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()

func _ready():
	pass

func _on_Finejo_body_enter( korpo ):
	print(korpo.get_name())
	if korpo.get_name() == "K":
		Agordejo.load(agordejo)
		if Agordejo.get_value("Niveloj", "P"+str(Tutmonda.pako)+"N"+str(Tutmonda.nivelo), 0) < int(Bazo.Tempilo.get_time_left()):
			Agordejo.set_value("Niveloj", "P"+str(Tutmonda.pako)+"N"+str(Tutmonda.nivelo),
				int(Bazo.Tempilo.get_time_left())
			)
			Agordejo.save(agordejo)
			Tutmonda.rekordita = true
		get_tree().change_scene("res://Niveloj.tscn")
