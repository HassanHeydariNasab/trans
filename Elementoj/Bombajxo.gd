extends Node2D

func _ready():
	pass

func _on_Areo_body_enter( korpo ):
	if korpo.get_name() == "M":
		korpo.vivo -= 1
		korpo.set_process(false)
		korpo.Halto_tempilo.start()
		korpo.get_node("Vivo").set_scale(Vector2(korpo.vivo/korpo.komenca_vivo,1))
		get_node("/root/Bazo/Bombajxo_sono").set("stream/play", Tutmonda.Agordejo.get_value("Agordoj", "Sonoj", true))
		if korpo.vivo <= 0:
#			get_node("/root/Nivelo/Navo").set_process(false)
#			get_node("/root/Bazo/Navo").set_fixed_process(false)
			korpo.queue_free()
		queue_free()
