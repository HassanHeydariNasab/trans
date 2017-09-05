extends Control

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()
const lingvoj = ["eo", "en"]

func _ready():
	get_tree().set_auto_accept_quit(true)
	Agordejo.load(agordejo)
	var lingvo_indekso = Agordejo.get_value("Lingvo", "lingvo")
	if TranslationServer.get_locale() != lingvoj[lingvo_indekso]:
		TranslationServer.set_locale(lingvoj[lingvo_indekso])
		get_tree().reload_current_scene()

func _on_Kodo_pressed():
	OS.shell_open("https://github.com/HassanHeydariNasab/trans")

func _on_Sxangxu_lingvon_pressed():
	get_tree().change_scene("res://Lingvo.tscn")

func _on_P1N1_pressed():
	Tutmonda.nivelo = 1
	get_tree().change_scene("res://Bazo.tscn")