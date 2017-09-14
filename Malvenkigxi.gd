extends Control

func _ready():
	if Tutmonda.malvenkigxi_kialo == "fintempo":
		get_node("Kialo/Kialo").set_text(tr("Tempo finigxis!"))
		get_node("Fintempo").play()
	elif Tutmonda.malvenkigxi_kialo == "mortigxi":
		get_node("Kialo/Kialo").set_text(tr("Vi mortigxis!"))
		get_node("Mortigxi").play()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().change_scene("res://Niveloj.tscn")

func _on_Rekomencu_pressed():
	if Tutmonda.nivelo == 3:
		get_tree().change_scene("res://Estro.tscn")
	else:
		get_tree().change_scene("res://Bazo.tscn")

func _on_Niveloj_pressed():
	get_tree().change_scene("res://Niveloj.tscn")