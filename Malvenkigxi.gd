extends Control

func _ready():
	if Tutmonda.malvenkigxi_kialo == "fintempo":
		get_node("Kialo/Kialo").set_text(tr("Tempo finigxis!"))
		get_node("Fintempo").set("stream/play", Tutmonda.Agordejo.get_value("Agordoj", "Sonoj", true))
	elif Tutmonda.malvenkigxi_kialo == "mortigxi":
		get_node("Kialo/Kialo").set_text(tr("Vi mortigxis!"))
		get_node("Mortigxi").set("stream/play", Tutmonda.Agordejo.get_value("Agordoj", "Sonoj", true))

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().change_scene("res://Niveloj.tscn")

func _on_Rekomencu_pressed():
	get_tree().change_scene("res://Bazo.tscn")

func _on_Niveloj_pressed():
	get_tree().change_scene("res://Niveloj.tscn")