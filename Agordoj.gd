extends Control

func _ready():
	get_tree().set_auto_accept_quit(false)
	get_node("Enveno_sono").set("stream/play", Tutmonda.Agordejo.get_value("Agordoj", "Sonoj", true))
	get_node("Sonoj").set_pressed(Tutmonda.Agordejo.get_value("Agordoj", "Sonoj", true))
	get_node("Muzikoj").set_pressed(Tutmonda.Agordejo.get_value("Agordoj", "Muzikoj", true))

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().change_scene("res://Niveloj.tscn")

func _on_Sonoj_toggled( b ):
	Tutmonda.Agordejo.set_value("Agordoj", "Sonoj", b)
	Tutmonda.Agordejo.save(Tutmonda.agordejo)

func _on_Muzikoj_toggled( b ):
	Tutmonda.Agordejo.set_value("Agordoj", "Muzikoj", b)
	Tutmonda.Agordejo.save(Tutmonda.agordejo)

func _on_Bone_pressed():
	get_tree().change_scene("res://Niveloj.tscn")