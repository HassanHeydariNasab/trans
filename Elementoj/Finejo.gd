extends Area2D

onready var Bazo = get_tree().get_root().get_node("/root/Bazo")

func _ready():
	pass

func _on_Finejo_body_enter( korpo ):
	if korpo.get_name() == "K":
		if Tutmonda.nivelo != 3:
			if Tutmonda.Agordejo.get_value("Niveloj", "P"+str(Tutmonda.pako)+"N"+str(Tutmonda.nivelo), 0) < int(Bazo.Tempilo.get_time_left()):
				Tutmonda.Agordejo.set_value("Niveloj", "P"+str(Tutmonda.pako)+"N"+str(Tutmonda.nivelo),
					int(Bazo.Tempilo.get_time_left())
				)
				Tutmonda.Agordejo.save(Tutmonda.agordejo)
				Tutmonda.rekordita = true
		else:
			Tutmonda.jxus_pasita = true
			Tutmonda.Agordejo.set_value("Niveloj", "P"+str(Tutmonda.pako)+"N"+str(Tutmonda.nivelo),
				true
			)
			Tutmonda.Agordejo.save(Tutmonda.agordejo)
		get_tree().change_scene("res://Niveloj.tscn")
