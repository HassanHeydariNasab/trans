extends Node2D

onready var Kamero = get_node("Kamero")
onready var K = get_node("K")
onready var Tempilo = get_node("Tempilo")
onready var Tempo = get_node("Kanvaso/Tempo")
onready var Nitrogenoj = get_node("Kanvaso/Nitrogenoj")
var tempo = 0
var minuto = 0
var sekundo = 0

func _ready():
	Tempilo.set_wait_time(Tempilo.get_time_left()+50)
	Tempilo.start()
	Tutmonda.nivelo = 1
	tempo = int(Tempilo.get_time_left())
	K.set_global_pos(Vector2(450,500))
	K.set_global_rot(deg2rad(90))
	set_process(true)

func _process(delta):
	tempo = int(Tempilo.get_time_left())
	minuto = "%02d" % (tempo/60)
	sekundo = "%02d" % (tempo%60)
	Tempo.set_text(str(minuto)+":"+str(sekundo))
	Kamero.set_offset(K.get_global_pos()+Vector2(0,-100))
	Nitrogenoj.set_value(K.nitrogenoj)

func _on_Tempo_timeout():
	get_tree().change_scene("res://Malvenkigxi.tscn")
