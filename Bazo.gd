extends Node2D

onready var Kamero = get_node("Kamero")
onready var K = get_node("K")
onready var Tempilo = get_node("Tempilo")
onready var Tempo = get_node("Kanvaso/Tempo")
onready var Nitrogenoj = get_node("Kanvaso/Nitrogenoj")
onready var Montrilo = get_node("Kanvaso/Montrilo/Montrilo")
onready var FPS = get_node("Kanvaso/FPS")
onready var Finejo = null

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()

var tempo = 0
var minuto = 0
var sekundo = 0
var L = Vector2()

func _ready():
	get_tree().set_auto_accept_quit(false)
	Agordejo.load(agordejo)
	tempo = int(Tempilo.get_time_left())
	K.set_global_pos(Vector2(450,500))
	K.set_global_rot(deg2rad(90))
	add_child(load("res://Niveloj/Nivelo%d.tscn" % Tutmonda.nivelo).instance())
	var Nivelo = get_node("Nivelo")
	Tempilo.set_wait_time(Nivelo.tempo)
	Tempilo.start()
	move_child(Nivelo,0)
	Finejo = Nivelo.get_node("Finejo")
	set_process(true)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().change_scene("res://Niveloj.tscn")

func _process(delta):
	FPS.set_text(str(int(1.0/delta)))
	tempo = int(Tempilo.get_time_left())
	minuto = "%02d" % (tempo/60)
	sekundo = "%02d" % (tempo%60)
	Tempo.set_text(str(minuto)+":"+str(sekundo))
	Kamero.set_offset(K.get_global_pos()+Vector2(0,-100))
	Nitrogenoj.set_value(K.nitrogenoj)
	L = Finejo.get_global_pos() - K.get_global_pos()
	Montrilo.set_rot(atan2(L.x,L.y))

func _on_Tempo_timeout():
	get_tree().change_scene("res://Malvenkigxi.tscn")
