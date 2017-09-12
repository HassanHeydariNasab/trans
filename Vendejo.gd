extends Node2D

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()
const lingvoj = ["eo", "en"]

onready var Tempo = get_node("Tempo")
onready var Nitrogeno_Nombroj = get_node("Nitrogeno/Nombroj")
onready var Bombo_Nombroj = get_node("Bombo/Nombroj")

var sumo = 0
var sekundo = 0
var minuto = 0

func _ready():
	get_tree().set_auto_accept_quit(false)
	Agordejo.load(agordejo)
	for N in range(3):
		sumo += Agordejo.get_value("Niveloj", "P"+str(Tutmonda.pako)+"N"+str(N),0)
	minuto = "%02d" % (sumo/60)
	sekundo = "%02d" % (sumo%60)
	Tempo.set_text(str(minuto)+":"+str(sekundo))

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().change_scene("res://Niveloj.tscn")

func _on_Nitrogeno_pressed():
	if sumo >= 10:
		sumo -= 10
		minuto = "%02d" % (sumo/60)
		sekundo = "%02d" % (sumo%60)
		Tempo.set_text(str(minuto)+":"+str(sekundo))
		Tutmonda.nitrogenoj += 1
		Nitrogeno_Nombroj.set_text(str(Tutmonda.nitrogenoj))

func _on_Bombo_pressed():
	if sumo >= 5:
		sumo -= 5
		minuto = "%02d" % (sumo/60)
		sekundo = "%02d" % (sumo%60)
		Tempo.set_text(str(minuto)+":"+str(sekundo))
		Tutmonda.bomboj += 1
		Bombo_Nombroj.set_text(str(Tutmonda.bomboj))
